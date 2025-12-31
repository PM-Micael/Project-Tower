extends Control

@onready var _object_sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	for obj in get_tree().get_nodes_in_group("clickable_objects"):
		obj.connect("object_clicked", _on_object_clicked)

func _on_object_clicked(sprite: Sprite2D):
	_object_sprite.texture = sprite.texture
	_object_sprite.transform = sprite.transform / 5
	return
