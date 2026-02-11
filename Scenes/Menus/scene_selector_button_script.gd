extends Button

@export var _scene_path: String

func _pressed() -> void:
	get_tree().change_scene_to_file(_scene_path)
