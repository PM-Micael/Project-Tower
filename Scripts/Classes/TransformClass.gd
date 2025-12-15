extends Node2D

class_name TransformClass

var Position: Vector2
var _rotation: float

func _init(_pos: Vector2 = Vector2.ZERO, _rot: float = 0.0) -> void:
	position = _pos
