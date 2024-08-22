extends CanvasLayer

@onready var move_tutorial = $Control/MoveTutorial
@onready var jump_tutorial = $Control/JumpTutorial


func _ready():
	move_tutorial.set_pivot_offset(move_tutorial.get_size() / 2)
	jump_tutorial.set_pivot_offset(jump_tutorial.get_size() / 2)
	
	move_tutorial.set_scale(Vector2.ZERO)
	jump_tutorial.set_scale(Vector2.ZERO)
	
	await get_tree().create_timer(1).timeout
	
	var tween = create_tween()
	tween.tween_property(move_tutorial, "scale", Vector2.ONE, .2)
	
	if !Input.get_connected_joypads().is_empty():
		move_tutorial.get_node("InnerContainer/Label").set_visible(false)
		jump_tutorial.get_node("InnerContainer/Label").set_visible(false)
		move_tutorial.get_node("InnerContainer/JoypadVer").set_visible(true)
		jump_tutorial.get_node("InnerContainer/JoypadVer").set_visible(true)


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
		
		await tween.finished
		jump_tutorial.set_visible(false)
