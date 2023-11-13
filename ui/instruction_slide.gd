@tool
extends VBoxContainer

@export var image: Texture2D :
	set = _set_texture
@export var title: String :
	set = _set_title
@export_multiline var description: String :
	set = _set_description


func _set_texture(value: Texture2D) -> void:
	image = value
	$Panel/Image.texture = value


func _set_title(value: String) -> void:
	title = value
	$Title.text = value


func _set_description(value: String) -> void:
	description = value
	$Description.text = value
