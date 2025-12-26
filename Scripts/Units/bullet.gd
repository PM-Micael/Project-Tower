extends CharacterBody2D

@export var speed: float = 400.0
@export var damage: int = 1
@export var stop_distance: float = 70.0
@export var attack_cooldown: float = 1.0
@export var target: Node2D

func _physics_process(_delta: float) -> void:
	if target == null:
		queue_free()
		return

	var dir: Vector2 = target.global_position - global_position
	var dist: float = dir.length()

	if dist > stop_distance:
		velocity = dir.normalized() * speed
		move_and_slide()
	else:
		if target and target.has_method("take_damage"):
			target.call("take_damage", damage)
			queue_free()
