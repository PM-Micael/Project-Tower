extends Label

@onready var round_handler = get_node("/root/Game/DefendTower/RoundHandler")

func _ready() -> void:
	round_handler.connect("wave_update", Callable(self, "_on_wave_update"))

func _on_wave_update(wave_count: int):
	if round_handler:
		text = "Wave: " + str(wave_count) 
