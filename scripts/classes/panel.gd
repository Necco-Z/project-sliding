extends PanelContainer


func _ready():
	set_scale(Vector2.ZERO)
	set_pivot_offset(get_size() / 2)
	set_visible(false)


func show_panel():
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2.ONE, 0.2)
	set_visible(true)


func hide_panel():
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2.ZERO, 0.2)
	set_visible(false)
