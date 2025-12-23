extends Area2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("Ally_Targetable_Structure"):
		print("Enemy hitbox trigger")
		if body and body.has_method("take_damage"):
			var parent := get_parent() as CharacterBody2D
			if parent:
				parent.velocity = Vector2.ZERO
				body.call("take_damage", parent.current_attack)
			# Future bug. When target dies the enemy will keep standing still atm
	
