extends StaticBody3D


var game_run_handler


func _ready():
	game_run_handler = get_tree().get_nodes_in_group("handlers")[2]


func player_collided(body):
	game_run_handler.end_game()
