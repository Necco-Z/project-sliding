extends Node3D


const SPEED = 7.5
var game_running = false


func _physics_process(delta):
	if game_running:
		position.x += SPEED * delta
	
	
func begin_game():
	game_running = true


func end_game():
	game_running = false
