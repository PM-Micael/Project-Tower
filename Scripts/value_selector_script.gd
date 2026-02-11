extends Label
class_name ValueLabel

@export var tier_value: int = 1

func _ready() -> void:
	_update_text()

func set_value(new_tier_value: int) -> void:
	tier_value = new_tier_value
	_update_text()

func _update_text():
	text = "Tier: " + str(tier_value)

func increment(amount: int = 1) -> void:
	set_value(tier_value + amount)

func decrement(amount: int = 1) -> void:
	if (tier_value - amount) <= 0:
		return
	set_value(tier_value - amount)
