extends StaticBody2D

var maximum_health: int = 20
@onready var current_health: int = maximum_health

func _init() -> void:
	_set_stats()

func _set_stats():
	return

func take_damage(amount: int) -> void:
	current_health -= amount
	if current_health <= 0:
		current_health = 0
		queue_free()
