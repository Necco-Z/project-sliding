extends Control

@export_file("*.tscn") var game_scene_path

@export var anim_speed := 5.0

var anim_time := 0.4

@onready var bg_up := $LoadingScreen/BgUp as Sprite2D
@onready var bg_down := $LoadingScreen/BgDown as Sprite2D
@onready var load_screen := $LoadingScreen as TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ResourceLoader.load_threaded_request(game_scene_path)
	load_screen.visible = true
	load_screen.anchor_top = -1
	load_screen.anchor_bottom = 0
	Fader.fade_in()
	%StartButton.grab_focus()


func _process(delta: float) -> void:
	_animate_background(delta)
	

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


func _on_exit_button_pressed() -> void:
	Fader.fade_out()
	await Fader.fade_finished
	get_tree().quit()


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
