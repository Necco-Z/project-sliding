extends Control

@export var anim_speed := 5.0
@export var tween_intensity: float
@export var tween_duration: float

@onready var bg_up := $LoadingScreen/BgUp as Sprite2D
@onready var bg_down := $LoadingScreen/BgDown as Sprite2D
@onready var load_screen := $LoadingScreen as TextureRect
@onready var logo := $MainControls/GameLogo
@onready var main_controls := $MainControls
@onready var credits := $Credits
@onready var level_selector = $LevelSelector
@onready var skin_selector = $SkinSelect/HUD
@onready var menu_anim_player = $AnimationPlayer
@onready var all_buttons = get_tree().get_nodes_in_group("buttons")
@onready var audio_stream_hover_button = get_node("HoverSound")
@onready var audio_stream_pressed_button = get_node("PressedSound")

var focused: bool = false
var in_transition: bool = true
var actual_screen = 0
var game_scene_path
var anim_time := 0.4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#ResourceLoader.load_threaded_request(game_scene_path)
	load_screen.visible = true
	load_screen.anchor_top = -1
	load_screen.anchor_bottom = 0
	Fader.fade_in()
	if Input.get_connected_joypads().size() > 0:
		%StartButton.grab_focus()
		focused = true
	
	var animation_props = []
	for i in level_selector.get_children():
		animation_props.append(i)
	for i in credits.get_children():
		animation_props.append(i)
	for i in main_controls.get_children():
		animation_props.append(i)
	
	for i in animation_props:
		i.set_scale(Vector2.ZERO)
		i.set_pivot_offset(i.get_size()/2)
	
	for button in all_buttons: #button hover animation
		button.pivot_offset = button.size / 2 
		button.connect("mouse_entered", Callable(self, "hover_sound"))
		button.connect("button_up", Callable(self, "press_sound"))


func _process(delta: float) -> void:
	_animate_background(delta)


func _physics_process(_delta):
	for button in all_buttons: #button animation
		btn_hovered(button)


func _input(event):
	if event is InputEventMouseMotion:
		if main_controls.is_visible():
			for i in main_controls.get_child(1).get_children():
				i.release_focus()
		else:
			credits.get_child(2).release_focus()
		focused = false
	elif ((event is InputEventJoypadButton) and !focused):
		if main_controls.is_visible():
			%StartButton.grab_focus()
		else:
			credits.get_child(2).grab_focus()
		focused = true
	elif Input.get_connected_joypads().size() == 0 and focused:
		release_focus()
		for i in main_controls.get_child(1).get_children():
			i.release_focus()
		focused = false


func to_skin_selector():
	await Fader.fade_out()
	skin_selector.set_visible(true)
	level_selector.set_visible(false)
	$MenuBG.set_visible(false)
	get_tree().get_nodes_in_group("BG")[0].set_visible(false)
	await Fader.fade_in()
	
	
func back_from_skin_selector():
	await Fader.fade_out()
	skin_selector.set_visible(false)
	level_selector.set_visible(true)
	for i in level_selector.get_children():
		i.set_scale(Vector2.ZERO)
	$MenuBG.set_visible(true)
	get_tree().get_nodes_in_group("BG")[0].set_visible(true)
	await Fader.fade_in()
	
	var tween = create_tween()
	for i in level_selector.get_children():
		tween.tween_property(i, "scale", Vector2.ONE, 0.2)
	await tween.finished


func _on_start_button_pressed() -> void:
	ScoreData.reset_data()
	var t = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
	t.parallel().tween_property(load_screen, "anchor_top", 0, anim_time)
	t.parallel().tween_property(load_screen, "anchor_bottom", 1, anim_time)
	await t.finished
	var load_status = ResourceLoader.load_threaded_get_status(game_scene_path)
	while load_status != ResourceLoader.THREAD_LOAD_LOADED:
		load_status = ResourceLoader.load_threaded_get_status(game_scene_path)
		await get_tree().process_frame
	var game_scene = ResourceLoader.load_threaded_get(game_scene_path)
	Fader.fade_out()
	await Fader.fade_finished
	get_tree().change_scene_to_packed(game_scene)


func _on_credits_button_pressed() -> void:
	menu_anim_player.play("hide_main_menu")


func hide_main_menu() -> void:
	logo.set_visible(false)
	main_controls.set_visible(false)
	credits.set_visible(true)
	if focused:
		credits.get_child(2).grab_focus()


func _on_back_to_main_button_pressed() -> void:
	menu_anim_player.play("hide_credit")


func hide_credits() -> void:
	logo.set_visible(true)
	main_controls.set_visible(true)
	credits.set_visible(false)
	if focused:
		main_controls.get_child(0).grab_focus()


func _on_exit_button_pressed() -> void:
	Fader.fade_out()
	await Fader.fade_finished
	get_tree().quit()


func back_to_main_menu():
	actual_screen = 0
	var tween = create_tween()
	
	for i in level_selector.get_children():
		tween.tween_property(i, "scale", Vector2.ZERO, .2)
	
	await tween.finished
	level_selector.set_visible(false)
	main_controls.set_visible(true)
	menu_anim_player.play("show_main_menu")


func get_load_message(value: int) -> String:
	var t = ""
	match value:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			t = "Em progresso"
		ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
			t = "Inválido"
		ResourceLoader.THREAD_LOAD_FAILED:
			t = "Falha"
		ResourceLoader.THREAD_LOAD_LOADED:
			t = "Concluído"
	return t


func _animate_background(delta: float) -> void:
	var bg_size = bg_up.region_rect.size
	var anim_up = bg_up.region_rect.position.y
	var anim_down = bg_down.region_rect.position.y
	anim_up = fposmod(anim_up - anim_speed * delta, bg_size.y)
	anim_down = fposmod(anim_down + anim_speed * delta, bg_size.y)
	bg_up.region_rect.position.y = anim_up
	bg_down.region_rect.position.y = anim_down


func _on_menu_animation_finished(anim_name):
	if anim_name == "hide_credit":
		hide_credits()
		menu_anim_player.play("show_main_menu")
	elif anim_name == "hide_main_menu" and actual_screen == 0:
		hide_main_menu()
		menu_anim_player.play("show_credits")
	elif anim_name == "open_game":
		hide_credits()
		menu_anim_player.play("show_main_menu")


func btn_hovered(button: BaseButton): #button hover
	if button.is_hovered() or button.has_focus():
		var tween = create_tween()
		tween.tween_property(button, "scale", Vector2.ONE * tween_intensity, tween_duration)
	elif !$AnimationPlayer.is_playing():
		var tween = create_tween()
		tween.tween_property(button, "scale", Vector2.ONE, tween_duration)


func hover_sound():
	audio_stream_hover_button.play()


func press_sound():
	audio_stream_pressed_button.play()


func _on_main_music_finished():
	get_node("MainMusic").play()


func on_level_select(path:String):
	ResourceLoader.load_threaded_request(path)
	game_scene_path = path


func to_level_selector():
	actual_screen = 1
	menu_anim_player.play("hide_main_menu")
	await menu_anim_player.animation_finished
	
	var tween = create_tween()
	main_controls.set_visible(false)
	level_selector.set_visible(true)
	for i in level_selector.get_children():
		tween.tween_property(i, "scale", Vector2.ONE, 0.2)
	await tween.finished

