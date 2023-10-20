extends CharacterBody3D


const SPEED = 7.5


func _physics_process(delta):

	velocity.x = SPEED

	move_and_slide()
