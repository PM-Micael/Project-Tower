extends Area2D

@export var maximum_health: int = 100
@export var current_health: int
@export var maximum_attack_range: float = 100
@export var attack_cooldown: float = 1.0

var time_since_last_attack: float = 0

signal health_changed (current, maximum)

func _init() -> void:
	var data = Global.load_json("res://Files/test.json")
	if data:
		current_health = data["users"]["UID_123"]["progress"]["current_round"]["fort"]["core_stats"]["current_health"]
		maximum_health = data["users"]["UID_123"]["progress"]["current_round"]["fort"]["core_stats"]["maximum_health"]
		print(str(current_health))

func take_damage(amount: int) -> void:
	current_health -= amount
	if current_health <= 0:
		current_health = 0
	
	emit_signal("health_changed", current_health, maximum_health)
