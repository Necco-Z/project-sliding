### @tool, class_name e extends
extends Node
## Node responsável pelo score

### Sinais
signal coins_updated

### enums

### constantes
const GAME_SCENE_PATH := "res://scenes/main_game.tscn"

### variáveis de @export

### variáveis públicas
var coins: int :
	set = _set_coins
var prank_total: int
var game_scene: PackedScene
var load_status := ResourceLoader.THREAD_LOAD_IN_PROGRESS

### variáveis privadas

### variáveis de @onready


### funções herdadas (_init, _ready e outras)
func _ready() -> void:
	ResourceLoader.load_threaded_request(GAME_SCENE_PATH)


func _process(_delta: float) -> void:
	if load_status != ResourceLoader.THREAD_LOAD_LOADED:
		load_status = ResourceLoader.load_threaded_get_status(GAME_SCENE_PATH)
		if load_status == ResourceLoader.THREAD_LOAD_LOADED:
			game_scene = ResourceLoader.load_threaded_get(GAME_SCENE_PATH)


### funções públicas
func add_coins(value := 1) -> void:
	coins += value


func reset_data() -> void:
	coins = 0
	prank_total = 0


### funções privadas
func _update_ui() -> void:
	coins_updated.emit(coins)


### funções setters e getters
func _set_coins(value: int) -> void:
	coins = value
	_update_ui()
