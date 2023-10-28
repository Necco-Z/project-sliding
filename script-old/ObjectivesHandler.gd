extends Node


var coin_objective = 50
var prank_objective = 15

var prank_objective_done = false
var coin_objective_done = false

var prank_objective_punctuation = 5000
var coin_objective_punctuation = 5000

var punctuation_handler
var canvas_handler

var pranks_done:float = 0
var coins_obtained:float = 0


func _ready():
	punctuation_handler = get_tree().get_nodes_in_group("handlers")[0]
	canvas_handler = get_tree().get_nodes_in_group("handlers")[1]


func add_prank():
	pranks_done += 1
	verify_prank()

	if !prank_objective_done:
		send_to_progress_objective()


func verify_prank():
	if prank_objective_done:
		return

	if pranks_done >= prank_objective and !prank_objective_done:
		prank_objective_done = true
		punctuation_handler.objective_punctuation(prank_objective_punctuation, "Objetivo completo: Pegadinhas +" + str(prank_objective_punctuation))

		send_to_progress_objective()


func verify_coins(coins):
	if coin_objective_done:
		return

	coins_obtained = coins
	if coins >= coin_objective and !coin_objective_done:
		coin_objective_done = true
		punctuation_handler.objective_punctuation(coin_objective_punctuation, "Objetivo completo: Moedas +" + str(coin_objective_punctuation))

	send_to_progress_objective()


func send_to_progress_objective():
	var prank_percentage = float(pranks_done / prank_objective) * 100
	var coin_percentage = float(coins_obtained / coin_objective) * 100

	if coin_percentage > 100:
		coin_percentage = 100
	if prank_percentage > 100:
		prank_percentage = 100

	canvas_handler.change_objective_status(coin_percentage, prank_percentage)
