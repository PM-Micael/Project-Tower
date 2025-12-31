extends Label

@onready var _round_handler = get_node("/root/Game/DefendTower/RoundHandler")

func _ready() -> void:
	_round_handler.connect("wave_update", Callable(self, "_on_wave_update"))

func _on_wave_update(wave_count: int):
	if _round_handler:
		text = "Wave: " + str(wave_count) 
