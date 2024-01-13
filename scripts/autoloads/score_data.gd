### @tool, class_name e extends
extends Node
## Node responsável pelo score

### Sinais
signal score_updated
signal coins_updated

### enums

### constantes

### variáveis de @export

### variáveis públicas
var score: int :
	set = _set_score
var coins: int :
	set = _set_coins
var prank_total: int

### variáveis privadas

### variáveis de @onready
@onready var score_timer := $ScoreTimer as Timer


### funções herdadas (_init, _ready e outras)
func _ready() -> void:
	pass


### funções públicas
func start_score_timer() -> void:
	score_timer.start()


func pause_score_timer() -> void:
	score_timer.stop()


func add_score(value: int) -> void:
	score += value


func add_coins(value := 1) -> void:
	coins += value


func set_score_interval(value: float) -> void:
	score_timer.wait_time = value


func reset_data() -> void:
	score = 0
	coins = 0
	prank_total = 0


### funções privadas
func _update_ui() -> void:
	score_updated.emit(score)
	coins_updated.emit(coins)


### funções setters e getters
func _set_score(value: int) -> void:
	score = value
	_update_ui()


func _set_coins(value: int) -> void:
	coins = value
	_update_ui()


### funções de sinal
## Quando o timer acabar, adicionar ao score
func _on_score_timer_timeout() -> void:
	score += 1
