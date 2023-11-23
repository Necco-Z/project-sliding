extends Control
## Classe base para os menus

### Constantes
const ANIM_DURATION := 0.3

var is_submenu := false


### Funções básicas (_init, _ready e outras)
func _ready() -> void:
	pass


### Funções públicas
func show_menu(instant := false) -> void:
	visible = true
	if instant:
		anchor_left = 0
		anchor_right = 1
	else:
		var t = create_tween()
		t = t.set_parallel().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
		t.tween_property(self, "anchor_left", 0, ANIM_DURATION)
		t.tween_property(self, "anchor_right", 1, ANIM_DURATION)
		await t.finished


func hide_menu(instant := false) -> void:
	if instant:
		anchor_left = -1
		anchor_right = 0
	else:
		var t = create_tween()
		t = t.set_parallel().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
		t.tween_property(self, "anchor_left", -1, ANIM_DURATION)
		t.tween_property(self, "anchor_right", 0, ANIM_DURATION)
		await t.finished
		visible = false
