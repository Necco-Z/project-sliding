extends Control

@export var label_height := 60.0
@export var separator := 5.0

var current_tween: Tween


func _ready() -> void:
	pass


func add_label(label: Control) -> void:
	add_child(label)
	label.size = Vector2(label.size.x, label_height)
	if label.size.y > label_height:
		label_height = label.size.y
	label.position.x = 0
	label.position.y = (label_height + separator) * (get_child_count() - 1)


func remove_label(label: Control) -> void:
	if label.get_parent() != self:
		return

	var children = get_children()
	children.erase(label)
	label.queue_free()
	if children.size() == 0:
		return
	if current_tween:
		current_tween.kill()
	current_tween = create_tween().set_parallel()
	for i in children.size():
		var current_child := children[i] as Control
		var child_pos = Vector2(0, (label_height + separator) * i)
		current_tween.tween_property(current_child, "position", child_pos, 0.2)
