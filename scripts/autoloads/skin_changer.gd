extends Node


var skins = [preload("res://assets/models/actors/player/skin.tscn"), 
		preload("res://assets/models/actors/player/skin2.tscn"),
		preload("res://assets/models/actors/player/skin3.tscn"),
		preload("res://assets/models/actors/player/skin4.tscn"),
		preload("res://assets/models/actors/player/skin5.tscn"),
		preload("res://assets/models/actors/player/skin6.tscn"),
		preload("res://assets/models/actors/player/skin7.tscn")]

var skin_num:int


func update_skin(num: int):
	skin_num = num
	
	
func get_skin() -> Resource:
	return skins[skin_num]
