extends Node


var punctuation:int = 0
var coins:int = 0
var game_running = false

var punctuation_step:int = 0

var canvas_handler
var objective_handler

func _ready():
	canvas_handler = get_tree().get_nodes_in_group("handlers")[1]
	objective_handler = get_tree().get_nodes_in_group("handlers")[3]


func _physics_process(delta):
	pass


func prank_punctuation(new_punctuation:int, new_prank_description:String):
	punctuation += new_punctuation
	canvas_handler.change_punctuation_label(punctuation)
	canvas_handler.new_prank_label(new_prank_description)
	objective_handler.add_prank()


func objective_punctuation(new_punctuation, objective_description):
	punctuation += new_punctuation
	canvas_handler.change_punctuation_label(punctuation)
	canvas_handler.new_prank_label(objective_description)


func stop_game():
	game_running = false


func start_game():
	game_running = true


func result_score():
	canvas_handler.result_score(punctuation, coins)

