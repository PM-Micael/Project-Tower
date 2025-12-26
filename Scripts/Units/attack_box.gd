extends Area2D

@onready var attack_timer: Timer = $AttackTimer

var current_target: Node = null

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	attack_timer.timeout.connect(_on_attack_timer_timeout)

func _on_body_entered(body: Node) -> void:
	if not body.is_in_group("Ally_Targetable_Structure"):
		return

	current_target = body

	# Start attacking immediately + every second
	_attempt_attack()
	attack_timer.start()

func _on_body_exited(body: Node) -> void:
	if body == current_target:
		current_target = null
		attack_timer.stop()

func _on_attack_timer_timeout() -> void:
	_attempt_attack()

func _attempt_attack() -> void:
	if not is_instance_valid(current_target):
		current_target = null
		attack_timer.stop()
		return

	if current_target.has_method("take_damage"):
		var parent := get_parent() as CharacterBody2D
		if parent:
			current_target.take_damage(parent.current_attack)
