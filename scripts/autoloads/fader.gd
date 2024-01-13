extends CanvasLayer

signal fade_finished

var fade_time := 0.3
var is_fading := false

@onready var color := $Color as ColorRect


func set_transparent(value: bool):
	if not is_fading:
		color.modulate = Color.TRANSPARENT if value else Color.WHITE


func fade_in(instant := false):
	await _fade(true, instant)


func fade_out(instant := false):
	await _fade(false, instant)


func _fade(fading_in: bool, instant := false):
	if instant:
		color.modulate = Color.TRANSPARENT if fading_in else Color.WHITE
	else:
		var col = Color.TRANSPARENT if fading_in else Color.WHITE
		var prev = Color.WHITE if fading_in else Color.TRANSPARENT
		if not is_fading:
			is_fading = true
			color.modulate = prev
			var tween = create_tween()
			tween.tween_property(color, "modulate", col, fade_time)
			await tween.finished
			is_fading = false
	fade_finished.emit()
