extends CanvasLayer


@onready var tutorial_bg = $Control/ColorRect
@onready var move_tutorial = $Control/ColorRect/MoveTutorial
@onready var jump_tutorial = $Control/ColorRect/JumpTutorial


func _ready():
	var tutorial_size = tutorial_bg.get_size()
	tutorial_bg.set_pivot_offset(Vector2(tutorial_size.x / 2, tutorial_size.y))
	move_tutorial.set_pivot_offset(move_tutorial.get_size() / 2)
	jump_tutorial.set_pivot_offset(jump_tutorial.get_size() / 2)
	
	await get_tree().create_timer(1).timeout
	
	var tween = create_tween()
	tween.tween_property(tutorial_bg, "scale:y", 1, .2)
	tween.tween_property(move_tutorial, "scale", Vector2.ONE, .2)


func on_first_obstacle_surpassed(body):
	if body.is_in_group("player"):
		jump_tutorial.set_visible(true)
		
		var tween = create_tween()
		tween.tween_property(move_tutorial, "scale", Vector2.ZERO, .2)
		tween.tween_property(jump_tutorial, "scale", Vector2.ONE, .2)
		
		await tween.finished
		move_tutorial.set_visible(false)
		


func on_jump_tutorial_surpassed(body):
	if body.is_in_group("player"):
		var tween = create_tween()
		tween.tween_property(jump_tutorial, "scale", Vector2.ZERO, .3)
		tween.tween_property(tutorial_bg, "scale:y", 0, .3)
		
		await tween.finished
		jump_tutorial.set_visible(false)
		tutorial_bg.set_visible(false)
