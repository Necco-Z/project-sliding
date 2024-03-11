extends Control
# Automated splash screen
# Cycles through every child of the "Logos" node at a fixed duration

enum Mode {FADEIN, SHOW, FADEOUT, WAIT}

@export_file("*.tscn") var next_scene
@export var fade_time := 1.0
@export var show_time := 2.0
@export var wait_time := 1.0

var current_splash := -1
var current_mode := Mode.WAIT
var can_input := false
var input_pause := 0.1
var tween : Tween

@onready var logos := $Logos as Control
@onready var max_splash := logos.get_child_count()


func _ready() -> void:
	start_splash()


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") and can_input:
		_skip_mode()
		_pause_input()


func _pause_input() -> void:
	can_input = false
	await get_tree().create_timer(input_pause).timeout
	can_input = true


func _skip_mode() -> void:
	var next := int((current_mode + 1) % Mode.size())
	print("current mode: ", current_mode)
	print("next: ", next)
	if next < current_mode:
		current_splash += 1
	if current_splash >= max_splash:
		end_splash()
	else:
		_switch_mode(next)
		current_mode = Mode.values()[next]


func _switch_mode(to : Mode) -> void:
	if tween:
		tween.kill()
	tween = create_tween()
	var c = _get_control(current_splash)
	match to:
		Mode.FADEIN:
			print("start fadein - index ", current_splash)
			tween.tween_property(c, "modulate", Color.WHITE, fade_time)
		Mode.SHOW:
			print("start show - index ", current_splash)
			c.modulate = Color.WHITE
			tween.tween_interval(show_time)
		Mode.FADEOUT:
			print("start fadeout - index ", current_splash)
			tween.tween_property(c, "modulate", Color.TRANSPARENT, fade_time)
		Mode.WAIT:
			print("start wait - index ", current_splash)
			c.modulate = Color.TRANSPARENT
			tween.tween_interval(wait_time)
	tween.tween_callback(_skip_mode)


func _get_control(index: int) -> Control:
	return logos.get_child(index)


func _set_visible(index: int, value: bool) -> void:
	var c := _get_control(index) as Control
	c.modulate = Color.WHITE if value else Color.TRANSPARENT


func start_splash() -> void:
	Fader.fade_out(true)
	await get_tree().create_timer(1.0).timeout
	for c in logos.get_children():
		c.modulate = Color(1, 1, 1, 0)
		c.visible = true
	await Fader.fade_in()
	can_input = true
	_skip_mode()


func end_splash() -> void:
	await Fader.fade_out()
	get_tree().change_scene_to_file(next_scene)
