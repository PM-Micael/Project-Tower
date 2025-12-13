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

func _ready() -> void:
	var db_data = Global.load_json("res://Files/db.json")
	var fort_data = Global.load_json("res://Files/fort_progression.json")
	
	if db_data:
		current_health = db_data["users"]["UID_123"]["progress"]["current_round"]["fort"]["core_stats"]["current_health"]
		maximum_health = db_data["users"]["UID_123"]["progress"]["current_round"]["fort"]["core_stats"]["maximum_health"]
		tier_number = db_data["users"]["UID_123"]["progress"]["current_round"]["fort"]["tier"]
	
	if fort_data:
		canon_slot_cords = fort_data["tier_" + str(tier_number)]["canon_slot_cords"]
	
	_initialize_structures(canon_slot_cords)

func _initialize_structures(canon_slots: Dictionary) -> void:
	if canon_scene == null:
		return
	print("init")
	for slot_name in canon_slots:
		var slot_cords = canon_slots[slot_name]
		print(slot_name)
		print(slot_cords["x"])
		print(slot_cords["y"])
		
		var canon = canon_scene.instantiate()
		canon.global_position = Vector2(
			slot_cords["x"],
			slot_cords["y"]
		)
		
		canon.name = slot_name
		canon.core_scene = self
		add_child(canon)
		print("canon placed")
	
	return

func take_damage(amount: int) -> void:
	current_health -= amount
	if current_health <= 0:
		current_health = 0
	
	emit_signal("health_changed", current_health, maximum_health)
