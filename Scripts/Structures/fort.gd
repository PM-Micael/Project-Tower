extends Node2D

@export var canon_scene: PackedScene
@export var wall_scene: PackedScene
@onready var core_scene: Area2D = $Core
@onready var structures_node: Node2D = $Structures
@onready var bullets_node: Node2D = $Bullets

var _tier_number: int
var _canon_slot_cords: Dictionary

var _wall_slot_positions: Dictionary
var _wall_transforms: Array[Transform2D]

func _init() -> void:	
	_set_properties()

func _ready() -> void:
	_spawn_canons()
	_spawn_walls()

func _set_properties():
	var db_data = Global.load_json("res://Files/db.json")
	var fort_data = Global.load_json("res://Files/fort_progression.json")
	
	if db_data:
		_tier_number = db_data["users"]["UID_123"]["progress"]["fort"]["tier"]
	
	if fort_data:
		_canon_slot_cords = fort_data["tier_" + str(_tier_number)]["canon_slot_cords"]
		
		var wall_slots = fort_data["tier_" + str(_tier_number)]["wall_slots"]
		
		for slot_name in wall_slots.keys():
			var transform_dict = wall_slots[slot_name]["transform"]
			var pos = Vector2(transform_dict["x"], transform_dict["y"])
			var rot = deg_to_rad(transform_dict["rotation"]) # Transform2D uses radians
			var t = Transform2D(rot, pos)
			_wall_transforms.append(t)
			print("Loaded wall slot '%s': position=%s, rotation=%f radians" % [slot_name, pos, rot])

func _spawn_walls():
	if wall_scene == null || _wall_transforms == null || _wall_transforms.size() == 0:
		return
	
	for i in range(_wall_transforms.size()):
		var t: Transform2D = _wall_transforms[i]
		var wall = wall_scene.instantiate()
		
		wall.transform = t
		wall.name = "wall_%d" % i
		structures_node.add_child(wall)

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
