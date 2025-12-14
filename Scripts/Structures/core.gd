extends Area2D

@export var maximum_health: int = 100
@export var current_health: int
@export var maximum_attack_range: float = 100
@export var attack_cooldown: float = 1.0
@export var canon_scene: PackedScene

var time_since_last_attack: float = 0
var tier_number: int
var fort_tier: String
var canon_slot_cords: Dictionary

signal health_changed (current, maximum)

func _init() -> void:
	_set_core_stats()

func _set_core_stats():
	var db_data = Global.load_json("res://Files/db.json")
	
	if db_data:
		current_health = db_data["users"]["UID_123"]["progress"]["current_round"]["fort"]["core_stats"]["current_health"]
		maximum_health = db_data["users"]["UID_123"]["progress"]["current_round"]["fort"]["core_stats"]["maximum_health"]
		tier_number = db_data["users"]["UID_123"]["progress"]["current_round"]["fort"]["tier"]

func take_damage(amount: int) -> void:
	current_health -= amount
	if current_health <= 0:
		current_health = 0
	
	emit_signal("health_changed", current_health, maximum_health)
