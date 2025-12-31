extends Label

@onready var _round_handler_node = get_node("/root/Game/DefendTower/RoundHandler")

func _ready() -> void:
	_round_handler_node.connect("scrap_update", Callable(self, "_on_scrap_update"))

func _on_scrap_update(scrap_count: int):
	text = "Scrap: " + str(scrap_count)
