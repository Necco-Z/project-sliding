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
var max_coins: int
var prank_total: int

### variáveis privadas

### variáveis de @onready


### funções herdadas (_init, _ready e outras)
func _ready() -> void:
	pass


### funções públicas
func add_coins(value := 1) -> void:
	coins += value


func set_max_score() -> void:
	max_coins = coins
	coins = 0


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
