extends CharacterBody2D

# Combat stats
var base_health: int = 1
var maximum_health: int
@onready var current_health: int = maximum_health
@onready var predicted_current_health: int = current_health

var base_attack: int = 1
var maximum_attack: int
@onready var current_attack: int = maximum_attack

var speed: float = 200.0
var attack_cooldown: float = 1.0

#Other
var scrap_drop_on_death: int = 2 # Placeholder
var coin_drop_on_death: int = 1

@onready var _round_handler_node: Node2D

var _target: Node2D = null

func _physics_process(_delta: float) -> void:
	_ready_target()
	move_to_target()

func set_stats(health_multiplier: int, attack_multiplier: int):
	maximum_health = base_health * (health_multiplier * _round_handler_node.current_wave)
	maximum_attack = base_attack * (attack_multiplier * _round_handler_node.current_wave)

func move_to_target():
	if _target == null:
		return

	var dir: Vector2 = _target.global_position - global_position

	velocity = dir.normalized() * speed
	move_and_slide()

func take_damage(amount: int) -> void:
	current_health -= amount
	if current_health <= 0:
		if _round_handler_node.has_method("fetch_kill_rewards"):
			_round_handler_node.fetch_kill_rewards(scrap_drop_on_death, coin_drop_on_death)
		queue_free()

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
