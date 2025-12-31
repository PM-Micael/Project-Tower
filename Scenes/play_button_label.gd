extends Label

func _ready() -> void:
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND

func _gui_input(event):
	if event is InputEventMouseButton \
	and event.pressed \
	and event.button_index == MOUSE_BUTTON_LEFT:
		get_tree().change_scene_to_file("res://Scenes/Game.tscn")
