extends Node2D

@export var wave_duration: float = 10.0
@export var prep_phase_duration: float = 5.0
@export var round_tier: int = 2 # Placeholder
@export var enemy_spawner_scene: PackedScene

@onready var enemey_spawners_node: Node2D = $EnemySpawners

var current_wave: int = 1 # Placeholder
var wave_countdown: float = wave_duration
var prep_phase_countdown: float = prep_phase_duration
var in_prep_phase: bool
var _enemy_spawners: Dictionary
var _fort_tier_number: int
var _player_selected_map: String

# Enemy stats
var _enemy_maximum_health_multiplier: int
var _enemy_maximum_attack_multiplier: int

signal timer_update (title, count)
signal wave_update (count)

func _init() -> void:
	_set_properties()

func _ready() -> void:
	await get_tree().process_frame
	emit_signal("wave_update", current_wave)
	_place_enemy_spawners()

func _physics_process(delta: float) -> void:
	_counter(delta)

func _DEBUG_set_enemy_stats():
	var round_config_data = Global.load_json("res://Files/round_config.json")
	
	if round_config_data:
		_enemy_maximum_health_multiplier = round_config_data["tier_" + str(round_tier)]["wave_multipliers"]["health_multiplier"]
		_enemy_maximum_attack_multiplier = round_config_data["tier_" + str(round_tier)]["wave_multipliers"]["attack_multiplier"]
	
		print("Enemy Health: " + str(current_wave * _enemy_maximum_health_multiplier))
		print("Enemy Attack: " + str(current_wave * _enemy_maximum_attack_multiplier))

func _set_properties():
	_DEBUG_set_enemy_stats()
	var db_data = Global.load_json("res://Files/db.json")
	var fort_data = Global.load_json("res://Files/fort_progression.json")
	
	if db_data:
		_fort_tier_number = db_data["users"]["UID_123"]["progress"]["fort"]["tier"]
		_player_selected_map = db_data["users"]["UID_123"]["selected_map"]
	
	if fort_data:
		_enemy_spawners = fort_data["tier_" + str(_fort_tier_number)][_player_selected_map]["enemy_spawners"]

func _place_enemy_spawners():
	if enemy_spawner_scene == null:
		return

	for spawner_name in _enemy_spawners:
		var spawner_data = _enemy_spawners[spawner_name]

		var enemy_spawner = enemy_spawner_scene.instantiate()

		enemy_spawner.global_position = Vector2(
			spawner_data["transform"]["x"],
			spawner_data["transform"]["y"]
		)

		enemy_spawner.name = spawner_name
		enemey_spawners_node.add_child(enemy_spawner)

func _counter(delta: float):
	var title: String
	var counter: float
	 
	if in_prep_phase == false: # Wave countdown
		if wave_countdown > 0.0:
			wave_countdown -= delta
			title = "Wave duration"
			counter = wave_countdown
		else:
			wave_countdown = wave_duration
			in_prep_phase = true
	else: # Prep phase countdown
		if prep_phase_countdown > 0.0:
			prep_phase_countdown -= delta
			title = "Prep phase"
			counter = prep_phase_countdown
		else:
			prep_phase_countdown = prep_phase_duration
			in_prep_phase = false
			current_wave += 1
			emit_signal("wave_update", current_wave)
			_DEBUG_set_enemy_stats()
	
	emit_signal("timer_update", title, counter)
