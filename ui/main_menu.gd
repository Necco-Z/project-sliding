extends Control

@export_file("*.tscn") var game_scene_path

var game_scene: PackedScene
var anim_time := 0.4

@onready var load_screen := $LoadingScreen as ColorRect
@onready var logo := $LoadingScreen/LoadingLogo as Sprite2D
@onready var anim_player := $LoadingScreen/AnimationPlayer as AnimationPlayer



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_screen.visible = true
	load_screen.anchor_top = -1
	load_screen.anchor_bottom = 0
	logo.modulate = Color.TRANSPARENT
	Fader.fade_in()
	%StartButton.grab_focus()


func _on_start_button_pressed() -> void:
	ScoreData.reset_data()
	var t = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
	t.parallel().tween_property(load_screen, "anchor_top", 0, anim_time)
	t.parallel().tween_property(load_screen, "anchor_bottom", 1, anim_time)
	t.tween_property(logo, "modulate", Color.WHITE, 0.2)
	await t.finished
	anim_player.play("loading")
	while ScoreData.game_scene == null:
		await get_tree().process_frame
	Fader.fade_out()
	await Fader.fade_finished
	get_tree().change_scene_to_packed(ScoreData.game_scene)


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
