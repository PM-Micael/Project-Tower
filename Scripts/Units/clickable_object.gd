extends Area2D
class_name ClickableObject

signal object_clicked(sprite: Sprite2D)

@onready var _object_sprite: Sprite2D = get_parent().get_node("Sprite2D") as Sprite2D

func _ready() -> void:
	add_to_group("clickable_objects")

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton \
	and event.pressed \
	and event.button_index == MOUSE_BUTTON_LEFT:
		emit_signal("object_clicked", _object_sprite)
