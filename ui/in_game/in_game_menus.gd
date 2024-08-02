extends CanvasLayer

var current_menu: Control
var current_submenu: Control

@export var tween_intensity: float
@export var tween_duration: float

@onready var game_hud := $GameHUD as Control
@onready var blur := $BlurLayer.material as ShaderMaterial
@onready var all_buttons = get_tree().get_nodes_in_group("buttons") #button hover animation


### Funções básicas
func _ready() -> void:
	Fader.fade_in()
	for i in get_children():
		if i is Control and not i is ColorRect and not i.name == "GameHUD":
			i.hide_menu(true)
	change_menu("StartMenu", true)
	
	for button in all_buttons: #button_hover_animation
		button.pivot_offset = button.size / 2 


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		if current_menu == game_hud:
			game_hud.pause_pressed.emit()


func _physics_process(_delta):
	for button in all_buttons: #button hover animation
		btn_hovered(button)


### Funções públicas
func set_connections(game_scene: Node) -> void:
	for i in get_children():
		if not i is ColorRect:
			i.set_connections(game_scene)


func change_menu(to: String, instant := false) -> void:
	if current_menu and current_menu.name == to:
		return
	for i in get_children():
		if i is Control and i.name == to:
			if current_menu:
				current_menu.hide_menu(instant)
			i.show_menu(instant)
			current_menu = i
	var t = create_tween()

	if to != "GameHUD":
		t.tween_method(_set_blur_value, 0.0, 1.0, 0.3)
	else:
		t.tween_method(_set_blur_value, 1.0, 0.0, 0.3)


func open_submenu(submenu: String, instant := false) -> void:
	for i in get_children():
		if i is Control and i.name == submenu and i.is_submenu:
			i.show_menu(instant)
			current_submenu = i
			return

	printerr("Nenhum submenu chamado \"" + submenu + "\"")


func close_submenu(instant := false) -> void:
	if current_submenu:
		current_submenu.hide_menu(instant)
	else:
		printerr("Nenhum submenu aberto")


func start_countdown() -> void:
	game_hud.start_countdown()


func add_prank(score := 0, text := "") -> void:
	game_hud.add_prank(score, text)


func _set_blur_value(value: float) -> void:
	blur.set_shader_parameter("amount", value)
	
	
func start_tween(object: Object, property: String, final_val:Variant, duration: float):
	var tween = create_tween()
	tween.tween_property(object, property, final_val, duration)


func btn_hovered(button: BaseButton): #hover animation
	if button.is_hovered() or button.has_focus():
		start_tween(button, "scale", Vector2.ONE * tween_intensity, tween_duration)
	else:
		start_tween(button, "scale", Vector2.ONE, tween_duration)
