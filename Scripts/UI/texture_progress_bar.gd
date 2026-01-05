extends TextureProgressBar

@export var max_health := 100
@onready var core_scene = $"../../../../../DefendTower/Fort/Core"
var current_health := max_health

func _ready():
	max_value = max_health
	value = core_scene.current_health
	print(value)

func set_health(hp: int):
	current_health = clamp(hp, 0, max_health)
	value = current_health
