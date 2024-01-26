extends "res://scripts/classes/menus.gd"

signal start_pressed
signal return_pressed

@export var anim_speed := 5.0

@onready var bg_up := $BgUp as Sprite2D
@onready var bg_down := $BgDown as Sprite2D


func _ready() -> void:
	pass
	#anchor_left = -1
	#anchor_right = 0


func _process(delta: float) -> void:
	_animate_background(delta)


func set_connections(game_scene: Node) -> void:
	start_pressed.connect(game_scene._on_start_pressed)
	return_pressed.connect(game_scene._on_return_pressed)


func _animate_background(delta: float) -> void:
	var bg_size = bg_up.region_rect.size
	var anim_up = bg_up.region_rect.position.y
	var anim_down = bg_down.region_rect.position.y
	anim_up = fposmod(anim_up - anim_speed * delta, bg_size.y)
	anim_down = fposmod(anim_down + anim_speed * delta, bg_size.y)
	bg_up.region_rect.position.y = anim_up
	bg_down.region_rect.position.y = anim_down


func _on_start_button_pressed() -> void:
	start_pressed.emit()


func _on_return_button_pressed() -> void:
	return_pressed.emit()
