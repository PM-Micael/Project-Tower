extends CharacterBody2D

@export var attack_cooldown: float = 1.0
@export var bullet_scene: PackedScene
@export var core_scene: Area2D
@onready var fort_scene = get_parent().get_parent()

var _time_since_last_attack: float = 0
var _target : Node2D = null

func _physics_process(delta: float) -> void:
	_set_closest_core_target()
	_handle_attack(delta)
	
func _set_closest_target() -> void:
	var enemies = get_tree().get_nodes_in_group("Enemy Unit")
	
	enemies = enemies.filter(func(e):
		return is_instance_valid(e) and e.predicted_current_health > 0
	)
	
	if enemies.size() == 0:
		push_warning("No tower found in group 'tower'")
		return
	
	var closest: Node2D = enemies[0]
	var best_dist := closest.global_position.distance_to(global_position)

	for e in enemies:
		var node := e as Node2D
		var d := node.global_position.distance_to(global_position)
		if d < best_dist:
			best_dist = d
			closest = node
	
	_target = closest

func _set_closest_core_target() -> void:
	var enemies = get_tree().get_nodes_in_group("Enemy Unit")
	
	enemies = enemies.filter(func(e):
		return is_instance_valid(e) and e.predicted_current_health > 0
	)
	
	if enemies.size() == 0:
		return
	
	var closest: Node2D = enemies[0]
	var best_dist := closest.global_position.distance_to(core_scene.global_position)

	for e in enemies:
		var node := e as Node2D
		var d := node.global_position.distance_to(core_scene.global_position)
		if d < best_dist:
			best_dist = d
			closest = node
	
	_target = closest

func _handle_attack(delta: float) -> void:
	if _time_since_last_attack > 0.0:
		_time_since_last_attack -= delta
		return
	
	_time_since_last_attack = attack_cooldown
	_shoot()

func _shoot() -> void:
	if bullet_scene == null:
		push_warning("No bullet scene was assigned.")
		return
	
	if not is_instance_valid(_target):
		_target = null
		return
	
	if _target.predicted_current_health <= 0:
		return
	
	var bullet = bullet_scene.instantiate()
	
	bullet.global_position = global_position
	bullet.target = _target
	bullet.name = "Bullet"
	fort_scene.spawn_bullet(bullet)
	
	_target.predicted_current_health -= bullet.damage
