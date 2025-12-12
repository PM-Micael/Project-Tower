extends CharacterBody2D

@export var maximum_health: int = 6
@export var current_health: int
@export var predicted_current_health: int
@export var speed: float = 200.0
@export var stop_distance: float = 140.0
@export var attack_cooldown: float = 1.0

var _target: Node2D = null
var _time_since_last_attack: float = 0.0

func _ready() -> void:
	current_health = maximum_health
	predicted_current_health = current_health
	_ready_target()

func _ready_target() -> void:
	var fort = get_tree().get_nodes_in_group("Fort")

	if fort.size() == 0:
		push_warning("No tower found in group 'tower'")
		return

	var closest: Node2D = fort[0]
	var best_dist := closest.global_position.distance_to(global_position)

	for f in fort:
		var node := f as Node2D
		var d := node.global_position.distance_to(global_position)
		if d < best_dist:
			best_dist = d
			closest = node

	_target = closest
	

func _physics_process(delta: float) -> void:
	if _target == null:
		return

	var dir: Vector2 = _target.global_position - global_position
	var dist: float = dir.length()

	if dist > stop_distance:
		# Move toward the tower
		velocity = dir.normalized() * speed
		move_and_slide()
	else:
		# Close enough — stop and attack
		velocity = Vector2.ZERO
		move_and_slide()
		_handle_attack(delta)

func _handle_attack(delta: float) -> void:
	if _time_since_last_attack > 0.0:
		_time_since_last_attack -= delta
		return

	_time_since_last_attack = attack_cooldown
	_do_attack()

func _do_attack() -> void:
	if _target and _target.has_method("take_damage"):
		_target.call("take_damage", 1)
		

func take_damage(amount: int) -> void:
	current_health -= amount
	
	if current_health <= 0:
		
		queue_free()
