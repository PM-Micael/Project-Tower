extends Label

@onready var round_handler = get_node("/root/Game/DefendTower/RoundHandler")

func _ready() -> void:
	round_handler.connect("timer_update", Callable(self, "_on_timer_update"))

func _on_timer_update(title: String, count: float):
	if round_handler:
		text = title + ": " + str(int(count) + 1)
