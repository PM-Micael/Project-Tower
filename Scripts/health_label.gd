extends Label

@onready var core = get_node("/root/Game/DefendTower/Fort/Core")

func _ready() -> void:
	core.connect("health_changed", Callable(self, "_on_health_changed"))
	text = "100/100"

func _on_health_changed(current, maximum):
	if core:
		text = "%d/%d" % [current, maximum]
