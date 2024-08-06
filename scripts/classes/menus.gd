extends Control
## Classe base para os menus

### Constantes
const ANIM_DURATION := 0.3

var is_submenu := false


### Funções básicas (_init, _ready e outras)
func _ready() -> void:
	set_pivot_offset(get_size() / 2)


### Funções públicas
func set_connections(_game_scene: Node) -> void:
	printerr("Virtual function set_connections not overwritten on ", name)


func show_menu(instant := false) -> void:
	visible = true
	if instant:
		scale = Vector2.ONE
	else:
		var t = create_tween()
		t = t.set_parallel().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
		t.tween_property(self, "scale", Vector2.ONE, ANIM_DURATION)
		await t.finished


func hide_menu(instant := false) -> void:
	if instant:
		scale = Vector2.ZERO
	else:
		var t = create_tween()
		t = t.set_parallel().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
		t.tween_property(self, "scale", Vector2.ZERO, ANIM_DURATION)
		await t.finished
		visible = false
