extends CharacterBody2D

@export var base_health: int = 3
@export var maximum_health: int
@onready var current_health: int = maximum_health
@onready var predicted_current_health: int = current_health

@export var base_attack: int = 1
@export var maximum_attack: int
@onready var current_attack: int = maximum_attack

@export var speed: float = 200.0
@export var stop_distance: float = 140.0
@export var attack_cooldown: float = 1.0

var _target: Node2D = null

func _ready_target() -> void:
	var target = get_tree().get_nodes_in_group("Core")

	if target.size() == 0:
		push_warning("No tower found in group 'Fort'")
		return

	var closest: Node2D = target[0]
	var best_dist := closest.global_position.distance_to(global_position)

	for t in target:
		var node := t as Node2D
		var d := node.global_position.distance_to(global_position)
		if d < best_dist:
			best_dist = d
			closest = node

	_target = closest

func _physics_process(_delta: float) -> void:
	_ready_target()
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
		#velocity = Vector2.ZERO
		move_and_slide()

func set_stats(health_multiplier: int, attack_multiplier: int):
	maximum_health = base_health * health_multiplier
	maximum_attack = base_attack * attack_multiplier

func take_damage(amount: int) -> void:
	current_health -= amount
	
	if current_health <= 0:
		
		queue_free()
