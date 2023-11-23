extends CharacterBody3D


const SPEED = 7.5
const JUMP_VELOCITY = 4.5
const LANE_SWITCH_SPEED = 10

var moving_between_lanes:bool = false
var can_do_prank:bool = false
var alive = false
var direction = 0

var actual_prank_area:Area3D = null

var prank_warning
var animation_player

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _ready():
	prank_warning = get_node("PrankWarning")
	prank_warning.set_visible(false)
	animation_player = get_node("AnimationPlayer")


func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

	var character_will_move = switch_lanes()

	if character_will_move and can_do_prank:
		actual_prank_area.send_prank()

	if moving_between_lanes:
		velocity.z = direction * LANE_SWITCH_SPEED
	else:
		velocity.x = SPEED
		velocity.z = move_toward(velocity.z, 0, SPEED)

	if alive:
		move_and_slide()


func switch_lanes():
	var input_dir_right = Input.is_action_pressed("ui_right")
	var input_dir_left = Input.is_action_pressed("ui_left")

	if moving_between_lanes:
		return false

	if !input_dir_left and !input_dir_right:
		direction = 0
		return false

	if input_dir_left and input_dir_right:
		direction = 0
		return false

	elif input_dir_left and !position.z <= 0:
		animation_player.play("Rotate_player_left")
		moving_between_lanes = true
		direction = -1
		return true

	elif input_dir_right and !position.z >= 6:
		animation_player.play("Rotate_player_right")
		moving_between_lanes = true
		direction = 1
		return true


func on_lane_entered(body, position_z):
	position = Vector3(position.x, position.y, position_z)
	moving_between_lanes = false


func prank_available(area):
	can_do_prank = true
	actual_prank_area = area
	if !moving_between_lanes:
		animation_player.play("Prank_available")


func prank_unavailable(area):
	actual_prank_area = null
	can_do_prank = false
	prank_warning.set_visible(false)


func begin_game():
	alive = true


func end_game():
	alive = false
