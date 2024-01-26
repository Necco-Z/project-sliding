@tool
extends HBoxContainer

@export_range(0, 3) var value : int:
	set = _set_value
@export_group("Textures", "texture_")
@export var texture_lit: Texture2D:
	set = _set_texture_lit
@export var texture_unlit: Texture2D:
	set = _set_texture_unlit


func _reload_textures() -> void:
	if not Engine.is_editor_hint():
		return
	get_child(0).texture = texture_lit
	get_child(1).texture = texture_unlit
	get_child(2).texture = texture_unlit


func _set_value(input: int) -> void:
	input = value
	var children = get_children()
	for s in children:
		s.texture = texture_unlit
	for i in get_child_count():
		if i < input:
			children[i].texture = texture_lit


func _set_texture_lit(input: Texture2D) -> void:
	texture_lit = input
	_reload_textures()


func _set_texture_unlit(input: Texture2D) -> void:
	texture_unlit = input
	_reload_textures()
