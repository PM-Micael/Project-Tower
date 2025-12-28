extends Node2D

@export var spawn_cooldown: float = 1.0
@export var enemy_scene: PackedScene
@onready var _round_handler_node: Node2D = get_parent().get_parent()

var _enemy_base_health_multiplier: int
var _enemy_base_attack_multiplier: int 
var time_since_last_spawn: float = 0.0

func _ready() -> void:
	var round_config_data = Global.load_json("res://Files/round_config.json")
	
	if round_config_data:
		# These are why this is made in _ready and not _init
		_enemy_base_health_multiplier = round_config_data["tier_" + str(_round_handler_node.round_tier)]["wave_multipliers"]["health_multiplier"]
		_enemy_base_attack_multiplier = round_config_data["tier_" + str(_round_handler_node.round_tier)]["wave_multipliers"]["attack_multiplier"]

func _physics_process(delta: float) -> void:
	_counter(delta)

func _counter(delta: float):
	if _round_handler_node.in_prep_phase == false:
		if time_since_last_spawn > 0.0:
			time_since_last_spawn -= delta
			return
		else:
			time_since_last_spawn = spawn_cooldown
			spawn_unit()

func spawn_unit() -> void:
	if enemy_scene == null:
		push_warning("No enemy scene assigned!")
		return
		
	var enemy = enemy_scene.instantiate()
	enemy.set_stats(_enemy_base_health_multiplier, _enemy_base_attack_multiplier)
	add_child(enemy)
