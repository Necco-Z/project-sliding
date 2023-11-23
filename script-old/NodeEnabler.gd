extends Node3D


var enabled = false


func _ready():
	return
#	owner.set_visible(false)
#	owner.set_process_mode(Node.PROCESS_MODE_DISABLED)


func _on_area_entered(_area):
	return
#	owner.set_visible(true)
#	owner.set_process_mode(Node.PROCESS_MODE_INHERIT)


func _on_area_exited(_area):
	queue_free()
