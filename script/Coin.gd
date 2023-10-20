extends Area3D


var punctuation_handler
var mesh

func _ready():
	punctuation_handler = get_tree().get_nodes_in_group("handlers")[0]
	mesh = get_node("mesh")


func _physics_process(delta):
	mesh.rotate_y(0.1)


func coin_collected(body):
	punctuation_handler.coin_collected()
	queue_free()
