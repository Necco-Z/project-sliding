extends MarginContainer

@onready var label := $Panel/Label as Label


func start_anim(text := "Adicionar texto") -> void:
	var t = create_tween()
	label.text = text
	modulate = Color.TRANSPARENT
	## TODO: Fazer com que a notificação suma suavemente
	t.tween_property(self, "modulate", Color.WHITE, 0.2)
	t.tween_interval(1.6)
	t.tween_property(self, "modulate", Color.TRANSPARENT, 0.2)
	await t.finished
	queue_free()
