extends Node

var achievements_description = ["Finish the run",
		"Collect 75 coins", "Collect 120 coins"]
var concluded_achievements = [false, false, false]
var finish_hud
const COINS1 = 75
const COINS2 = 120


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
			get_tree().get_nodes_in_group("star")[count].get_texture().set_region(Rect2(468,140,106,101))
			get_tree().get_nodes_in_group("objective")[count].get_label_settings().set_font_color(Color("3f810c"))
			count += 1
			
	var level_achievements_count = 0
	var concluded_achievements_count = 0
	for i in Achievements.achievements[2]:
		if i:
			level_achievements_count += 1
	for i in concluded_achievements:
		if i:
			concluded_achievements_count += 1
	if concluded_achievements_count <= level_achievements_count:
		return
	Achievements.achievements[2] = concluded_achievements

func check_achievements() -> Array[bool]:
	return concluded_achievements
