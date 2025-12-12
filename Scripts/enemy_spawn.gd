extends Node2D

@export var spawn_cooldown: float = 5.0
@export var enemy_scene: PackedScene

var time_since_last_spawn: float = 0.0


func _ready() -> void:
	return	

func _physics_process(delta: float) -> void:
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
	enemy.global_position = global_position
	get_parent().add_child(enemy)
