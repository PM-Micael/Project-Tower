extends Label

@onready var round_handler = get_node("/root/Game/DefendTower/RoundHandler")

func _ready() -> void:
	if round_handler:
		text = "Tier: " + str(round_handler.round_tier)
