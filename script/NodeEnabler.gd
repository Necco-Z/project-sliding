extends Node3D


var enabled = false


func _ready():
	var parent = get_parent()
	#parent.set_visible(false)
	#parent.set_process_mode(Node.PROCESS_MODE_DISABLED)


func _physics_process(delta):
	if !enabled:
		return

	var parent = get_parent()
	parent.set_visible(true)
	parent.set_process_mode(Node.PROCESS_MODE_INHERIT)


func enable_node(body):
	enabled = true


func behind_player(area):
	get_parent().queue_free()
