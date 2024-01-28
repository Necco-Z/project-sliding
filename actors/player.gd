extends CharacterBody3D

signal prank_executed(gui_name: String, score: int)
signal player_collided
signal coin_collected

@export_node_path("Node3D") var track_points_node
@export var speed := 8
@export var lane_switch_time := 0.5
@export var jump_time := 1.5
@export var jump_height := 2.5
@export var raycast_distance := 6

var is_active := false
var can_control := false
var is_moving := false
var current_lane := 1
var player_zpos := 0.0
var is_jumping := false
var player_ypos := 0.0
var is_near_prankable := false

@onready var track_points := get_node(track_points_node).get_children()
@onready var anim_playback := ($AnimationTree["parameters/playback"]
		as AnimationNodeStateMachinePlayback)
@onready var raycast := $RayCast3D as RayCast3D
@onready var lamp_anim := $lamp/AnimationPlayer as AnimationPlayer


# Funções virtuais e herdadas
func _ready() -> void:
	raycast.target_position.x = raycast_distance


func _physics_process(delta: float) -> void:
	if can_control:
		if not is_moving:
			_set_lane_movement()
		if not is_jumping:
			_set_jump()
	if is_active:
		_check_for_prankables()
		var new_dir = Vector3.RIGHT * speed * delta
		new_dir.z = player_zpos - global_position.z
		new_dir.y = player_ypos - global_position.y
		var col = move_and_collide(new_dir)
		if col:
			player_collided.emit()


# Funções públicas
func set_connections(main_scene: Node) -> void:
	prank_executed.connect(main_scene._on_prank_executed)
	player_collided.connect(main_scene._on_player_collided)


func collect_coin() -> void:
	ScoreData.coins += 1


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


func _set_jump() -> void:
	if Input.is_action_just_pressed("jump"):
		is_jumping = true
		var t = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
		t.tween_property(self, "player_ypos", jump_height, jump_time * 0.5)
		t.tween_interval(jump_time * 0.1)
		t.tween_property(self, "player_ypos", 0, jump_time * 0.4).set_ease(Tween.EASE_IN)
		await t.finished
		is_jumping = false


func _set_move_animation(dir: int) -> void:
	if dir == 1:
		anim_playback.travel("Right")
	elif dir == -1:
		anim_playback.travel("Left")


func _check_for_prankables() -> void:
	if raycast.is_colliding() and not is_near_prankable:
		is_near_prankable = true
		lamp_anim.play("show_lamp")
	elif not raycast.is_colliding() and is_near_prankable:
		is_near_prankable = false
		lamp_anim.play("hide_lamp")


func _execute_prank() -> void:
	var prankable = raycast.get_collider()
	prank_executed.emit(prankable.gui_name, prankable.score)
	prankable.animate_prank()
	#TODO: Adicionar animação de prank no personagem


func _get_track_zpos(lane: int) -> float:
	return track_points[lane].global_position.z


# Setters and getters
