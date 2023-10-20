extends Label


var animation_player


func _ready():
	animation_player = get_parent().get_parent().get_node("AnimationPlayer")
	animation_player.play("ready")


func disable_label():
	get_parent().get_parent().queue_free()
