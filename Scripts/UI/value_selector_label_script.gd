extends Label
class_name ValueLabel

@export var text_key: String
@export var text_value: String
@export var is_int: bool
@export var iterations: Array
var iteration_index: int = 0

func _enter_tree() -> void:
	_update_text()

func set_properties(set_text_key: String,
set_text_value: String,
set_is_int: bool):
	text_key = set_text_key
	text_value = set_text_value
	is_int = set_is_int

func set_value(new_index: int) -> void:
	iteration_index = new_index
	_update_text()

func _update_text():
	text = text_key + str(iterations[iteration_index])

func increment() -> void:
	if iteration_index > iterations.size():
		return
	set_value(iteration_index + 1)

func decrement() -> void:
	if iteration_index < 0:
		return
	set_value(iteration_index - 1)
