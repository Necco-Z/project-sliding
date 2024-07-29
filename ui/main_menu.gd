extends Control

@export_file("*.tscn") var game_scene_path

@export var anim_speed := 5.0
@export var tween_intensity: float
@export var tween_duration: float

var anim_time := 0.4

@onready var bg_up := $LoadingScreen/BgUp as Sprite2D
@onready var bg_down := $LoadingScreen/BgDown as Sprite2D
@onready var load_screen := $LoadingScreen as TextureRect
@onready var logo := $GameLogo
@onready var main_controls := $MenuBG/MainControls
@onready var credits := $MenuBG/Credits
@onready var menu_anim_player = $AnimationPlayer
@onready var main_buttons = [$MenuBG/MainControls/StartButton, 
		$MenuBG/MainControls/BoxContainer3/CreditsButton, 
		$MenuBG/MainControls/BoxContainer3/ExitButton]
@onready var all_buttons = get_tree().get_nodes_in_group("buttons")

var focused: bool = false
var in_transition: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ResourceLoader.load_threaded_request(game_scene_path)
	load_screen.visible = true
	load_screen.anchor_top = -1
	load_screen.anchor_bottom = 0
	Fader.fade_in()
	if Input.get_connected_joypads().size() > 0:
		%StartButton.grab_focus()
		focused = true
	
	for button in all_buttons: #button hover animation
		button.pivot_offset = button.size / 2 


func _process(delta: float) -> void:
	_animate_background(delta)


func _physics_process(_delta):
	for button in all_buttons: #button animation
		btn_hovered(button)


func _input(event):
	if event is InputEventMouseMotion:
		if main_controls.is_visible():
			for i in main_buttons:
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
		for i in main_buttons:
			i.release_focus()
		focused = false


func to_skin_selector():
	for menu in get_tree().get_nodes_in_group("MainMenu"):
		menu.set_visible(false)
	for menu in get_tree().get_nodes_in_group("SkinSelectorMenu"):
		menu.set_visible(true)


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


func to_main_menu():
	for menu in get_tree().get_nodes_in_group("MainMenu"):
		menu.set_visible(true)
	for menu in get_tree().get_nodes_in_group("SkinSelectorMenu"):
		menu.set_visible(false)


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
	elif anim_name == "hide_main_menu":
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
