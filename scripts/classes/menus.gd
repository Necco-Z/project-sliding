extends Control
## Classe base para os menus

### Variáveis de @onready
@onready var anim_player := $AnimationPlayer as AnimationPlayer


### Funções básicas (_init, _ready e outras)
func _ready() -> void:
	pass


### Funções públicas
func show_menu() -> void:
	anim_player.play("show")


func hide_menu() -> void:
	anim_player.play("hide")
