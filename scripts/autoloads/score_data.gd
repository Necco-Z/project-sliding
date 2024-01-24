### @tool, class_name e extends
extends Node
## Node responsável pelo score

### Sinais
signal coins_updated

### enums

### constantes

### variáveis de @export

### variáveis públicas
var coins: int :
	set = _set_coins
var prank_total: int

### variáveis privadas

### variáveis de @onready


### funções herdadas (_init, _ready e outras)
func _ready() -> void:
	pass


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
