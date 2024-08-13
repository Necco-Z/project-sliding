extends Node

var achievements_description = ["Completar nível",
		"Coletar 50 moedas", "Coletar 70 moedass"]
var concluded_achievements = [false, false, false]
var finish_hud
const COINS1 = 50
const COINS2 = 70


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
			
	var level_achievements_count = 0
	var concluded_achievements_count = 0
	for i in Achievements.achievements[1]:
		if i:
			level_achievements_count += 1
	for i in concluded_achievements:
		if i:
			concluded_achievements_count += 1
	if concluded_achievements_count <= level_achievements_count:
		return
	Achievements.achievements[1] = concluded_achievements

func check_achievements() -> Array[bool]:
	return concluded_achievements
