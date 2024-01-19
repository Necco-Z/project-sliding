extends CharacterBody3D

@export_node_path("Node3D") var track_points_node
@export var speed := 7.5
@export var lane_switch_time := 0.5

var is_active := false:
	set = _set_active
var can_control := false:
	set = _set_control
var is_moving := false
var current_lane := 1
var player_zpos := 0.0

@onready var track_points := get_node(track_points_node).get_children()


# Funções herdadas
func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	if can_control and not is_moving:
		_set_lane_movement()
	if is_active:
		var new_dir = Vector3.RIGHT * speed * delta
		new_dir.z = player_zpos - global_position.z
		move_and_collide(new_dir)


# Funções internas
func _set_lane_movement() -> void:
	var move_dir = roundf(Input.get_axis("move_left", "move_right"))
	if move_dir == 0:
		return

	var last_lane = current_lane
	current_lane = clampi(current_lane + move_dir, 0, track_points.size() - 1)
	if current_lane != last_lane:
		is_moving = true
		var t = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
		t.tween_property(self, "player_zpos", _get_track_zpos(current_lane), lane_switch_time)
		await t.finished
		is_moving = false


func _get_track_zpos(lane: int) -> float:
	return track_points[lane].global_position.z


# Setters and getters
func _set_active(value: bool) -> void:
	if value == false:
		can_control = false
	is_active = value


func _set_control(value: bool) -> void:
	if value == true:
		is_active = true
	can_control = value
