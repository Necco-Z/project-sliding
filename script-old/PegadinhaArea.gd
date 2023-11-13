extends Area3D

signal prank_completed

@export var prank_punctuation:int = 1
@export var prank_description:String = "Boneco de neve"


func give_credits():
	var punctuation_handler = get_tree().get_nodes_in_group("handlers")[0]
	punctuation_handler.prank_punctuation(prank_punctuation, prank_description + " + " + str(prank_punctuation))
