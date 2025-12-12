extends Label

@onready var core = get_node("/root/Game/DefendTower/Fort/Core")

func _ready() -> void:
	core.connect("health_changed", Callable(self, "_on_health_changed"))
	_on_health_changed(core.current_health, core.maximum_health)

func _on_health_changed(current, maximum):
	if core:
		text = "%d/%d" % [current, maximum]
