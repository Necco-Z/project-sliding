extends CharacterBody3D

signal prank_executed(gui_name: String, score: int)
signal player_collided

@export_node_path("Node3D") var track_points_node
@export var speed := 7.5
@export var lane_switch_time := 0.5
@export var raycast_distance := 6

var is_active := false:
	set = _set_active
var can_control := false:
	set = _set_control
var is_moving := false
var current_lane := 1
var player_zpos := 0.0
var is_near_prankable := false

@onready var track_points := get_node(track_points_node).get_children()
@onready var anim_playback := ($AnimationTree["parameters/playback"]
		as AnimationNodeStateMachinePlayback)
@onready var raycast := $RayCast3D as RayCast3D


# Funções virtuais e herdadas
func _ready() -> void:
	raycast.target_position.x = raycast_distance


func _physics_process(delta: float) -> void:
	if can_control and not is_moving:
		_check_for_prankables()
		_set_lane_movement()
	if is_active:
		var new_dir = Vector3.RIGHT * speed * delta
		new_dir.z = player_zpos - global_position.z
		var col = move_and_collide(new_dir)
		if col:
			player_collided.emit()


# Funções públicas
func set_connections(main_scene: Node) -> void:
	prank_executed.connect(main_scene._on_prank_executed)
	player_collided.connect(main_scene._on_player_collided)


# Funções privadas
func _set_lane_movement() -> void:
	var move_dir = roundf(Input.get_axis("move_left", "move_right"))
	if move_dir == 0:
		return
	var last_lane := current_lane
	current_lane = clampi(current_lane + move_dir, 0, track_points.size() - 1)
	if current_lane != last_lane:
		if raycast.is_colliding():
			_execute_prank()
		is_moving = true
		var t = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
		t.tween_property(self, "player_zpos", _get_track_zpos(current_lane), lane_switch_time)
		_set_move_animation(current_lane - last_lane)
		await t.finished
		is_moving = false


func _set_move_animation(dir: int) -> void:
	if dir == 1:
		anim_playback.travel("Right")
	elif dir == -1:
		anim_playback.travel("Left")


func _check_for_prankables() -> void:
	if raycast.is_colliding() and not is_near_prankable:
		is_near_prankable = true
		print("prankable detected: ", raycast.get_collider().name)
	elif not raycast.is_colliding() and is_near_prankable:
		is_near_prankable = false
		print("no prankables detected")


func _execute_prank() -> void:
	var prankable = raycast.get_collider()
	prank_executed.emit(prankable.gui_name, prankable.score)
	prankable.animate_prank()
	#TODO: Adicionar animação de prank no personagem


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
