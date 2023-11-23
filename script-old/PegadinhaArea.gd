extends Area3D

signal prank_executed


func send_prank():
	prank_executed.emit()
