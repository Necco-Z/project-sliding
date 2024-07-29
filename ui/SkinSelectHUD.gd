extends Node


@onready var camera = $World/Camera3D
@onready var select_buttons = [$Levels/RightArrow, $Levels/LeftArrow]
@onready var skins = get_tree().get_nodes_in_group("skins")

var skin_num: int = 0
var camera_tweener
var camera_animation_is_running = false
var skin_tweener


func show_menu():
	skin_tweener = create_tween()
	skin_tweener.tween_property(skins[skin_num], "rotation:y", 2 * PI, 2).as_relative()
	skin_tweener.set_loops()


func on_select_left():
	if skin_num > 0 and !camera_tweener.is_running():
		skin_num -= 1
		camera_animation_is_running = true
		
		camera_tweener = create_tween()
		camera_tweener.tween_property(camera, "position:z", -5.75, 0.2).as_relative()
		camera_tweener.set_ease(Tween.EASE_IN)
		await camera_tweener.finished
		
		if skin_tweener != null:
			skin_tweener.stop()
			skins[skin_num - 1].rotation.y = deg_to_rad(-132.9)
		
		skin_tweener = create_tween()
		skin_tweener.tween_property(skins[skin_num], "rotation:y", 2 * PI, 2).as_relative()
		skin_tweener.set_loops()
		camera_animation_is_running = false
		select_buttons[0].set_visible(true)
		
		if skin_num <= 0:
			select_buttons[1].set_visible(false)


func on_select_right():
	if skin_num <= 6:
		skin_num += 1
		camera_animation_is_running = true
		
		camera_tweener = create_tween()
		camera_tweener.tween_property(camera, "position:z", 5.75, 0.2).as_relative()
		camera_tweener.set_ease(Tween.EASE_IN)
		await camera_tweener.finished
		
		if skin_tweener != null:
			skin_tweener.stop()
			skins[skin_num - 1].rotation.y = deg_to_rad(-132.9)
		
		skin_tweener = create_tween()
		skin_tweener.tween_property(skins[skin_num], "rotation:y", 2 * PI, 2).as_relative()
		skin_tweener.set_loops()
		camera_animation_is_running = false
		select_buttons[1].set_visible(true)
		
		if skin_num >= 6:
			select_buttons[0].set_visible(false)


func reset_skin():
	skin_tweener.stop()
	skins[skin_num].rotation.y = deg_to_rad(-132.9)
	skin_num = 0
	camera.position.z = -1.838
	select_buttons[0].set_visible(true)
	select_buttons[1].set_visible(false)


func select_skin():
	SkinChanger.update_skin(skin_num)
