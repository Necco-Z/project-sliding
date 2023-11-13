extends Node

signal prank_changed(text: String)


var punctuation_label

var coins_label
var coins_panel
var coins_timer

var prank_area

var animation_player_canvas


func _ready():
	var labels = get_tree().get_nodes_in_group("labels")
	coins_label = labels[0]
	coins_panel = coins_label.get_parent().get_parent()
	coins_timer = coins_panel.get_node("Timer")
	punctuation_label = labels[1]
	prank_area = labels[2]
	animation_player_canvas = get_tree().get_nodes_in_group("animation_player")[1]
	print(coins_label.name)
	print(coins_panel.name)
	print(coins_timer.name)
	print(punctuation_label.name)


func change_punctuation_label(value:int):
	punctuation_label.set_text(str(value))


func new_prank_label(description:String):
	prank_changed.emit(description)


func change_coin_label(value:int):
	coins_panel.set_visible(true)
	coins_panel.set_modulate(Color(1,1,1,1))
	coins_timer.start()
	coins_label.set_text(str(value))


func hide_coins():
	animation_player_canvas.play("coin_label_disappear")


func result_score(punctuation, coins):
	var end_game_punctuation_label = get_tree().get_nodes_in_group("end_game_ui")[0]
	var end_game_coins_label = get_tree().get_nodes_in_group("end_game_ui")[1]

	end_game_punctuation_label.set_text(str(punctuation))
	end_game_coins_label.set_text(str(coins))


func change_objective_status(objective1, objective2):
	var objective1_progress_bar = get_tree().get_nodes_in_group("progress_bar")[0]
	var objective2_progress_bar = get_tree().get_nodes_in_group("progress_bar")[1]
	var objective3_progress_bar = get_tree().get_nodes_in_group("progress_bar")[2]
	var objective4_progress_bar = get_tree().get_nodes_in_group("progress_bar")[3]

	objective1_progress_bar.set_value(objective1)
	objective2_progress_bar.set_value(objective2)
	objective3_progress_bar.set_value(objective1)
	objective4_progress_bar.set_value(objective2)
