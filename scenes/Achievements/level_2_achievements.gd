extends Node

var achievement_completed_texture = preload("res://assets/sprites/ui/star_objective_ui_big.png")

var achievements_description = ["Completar nível",
		"Coletar 70 moedas", "Coletar 95 moedass"]
var concluded_achievements = [false, false, false]
var finish_hud
const COINS1 = 70
const COINS2 = 95


func _ready():
	finish_hud = get_tree().get_nodes_in_group("HUD")[1]
	for hud in get_tree().get_nodes_in_group("HUD"):
		if hud.name == "GameHUD":
			continue
		var count = 0
		for label in hud.get_child(1).get_child(2).get_children():
			label.set_text(achievements_description[count])
			count += 1

func level_finished(body):
	if !body.is_in_group("player"):
		return
	concluded_achievements[0] = true
	var coins = get_tree().get_nodes_in_group("player")[0].get_coins()
	print(coins)
	if coins >= COINS1:
		concluded_achievements[1] = true
	if coins >= COINS2:
		concluded_achievements[2] = true
	var count = 0
	for i in concluded_achievements:
		if i:
			finish_hud.get_child(1).get_child(1).get_children()[count].set_texture(achievement_completed_texture)
			count += 1

func check_achievements() -> Array[bool]:
	return concluded_achievements
