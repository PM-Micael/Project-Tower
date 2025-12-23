extends StaticBody2D

var maximum_health: int = 5
var current_health: int = 1

func take_damage(amount: int) -> void:
	print("Wall took damage")
	current_health -= amount
	if current_health <= 0:
		current_health = 0
		queue_free()
