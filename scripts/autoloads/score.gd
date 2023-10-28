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
var score: int
var coins: int

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


### funções privadas
func _update_score_ui() -> void:
	score_updated.emit(score)
	coins_updated.emit(coins)


### funções auxiliares


### funções de sinal
## Quando o timer acabar, adicionar ao score
func _on_score_timer_timeout() -> void:
	score += 1
