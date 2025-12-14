extends Node2D

@export var canon_scene: PackedScene
@onready var core_scene: Area2D = $Core
@onready var structures_node: Node2D = $Structures
@onready var bullets_node: Node2D = $Bullets

var _tier_number: int
var _canon_slot_cords: Dictionary

func _init() -> void:
	_set_properties()

func _ready() -> void:
	_spawn_canons()

func _set_properties():
	var db_data = Global.load_json("res://Files/db.json")
	var fort_data = Global.load_json("res://Files/fort_progression.json")
	
	if db_data:
		_tier_number = db_data["users"]["UID_123"]["progress"]["fort"]["tier"]
	
	if fort_data:
		_canon_slot_cords = fort_data["tier_" + str(_tier_number)]["canon_slot_cords"]
		

func _spawn_canons():
	if canon_scene == null || _canon_slot_cords == null || _canon_slot_cords.size() == 0:
		return
	
	for slot_name in _canon_slot_cords:
		var slot_cords = _canon_slot_cords[slot_name]
		
		var canon = canon_scene.instantiate()
		canon.global_position = Vector2(
			slot_cords["x"],
			slot_cords["y"]
		)
		
		canon.name = slot_name
		canon.core_scene = core_scene
		structures_node.add_child(canon)

func spawn_bullet(bullet: Node2D):
	bullets_node.add_child(bullet)
