extends Node

var achievements_description = ["Completar nível",
		"Coletar 75 moedas", "Coletar 100 moedass"]
var concluded_achievements = [false, false, false]
var finish_hud
const COINS1 = 75
const COINS2 = 100


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
	if coins >= COINS1:
		concluded_achievements[1] = true
	if coins >= COINS2:
		concluded_achievements[2] = true
	var count = 0
	for i in concluded_achievements:
		if i:
			finish_hud.get_child(1).get_child(1).get_children()[count].get_child(0).get_texture().set_region(Rect2(468,140,106,101))
			count += 1

func check_achievements() -> Array[bool]:
	return concluded_achievements
