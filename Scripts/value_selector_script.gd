extends Control

## ValueLabel properties
@export var value_label: PackedScene
var label_text_key: String
var label_text_value: String
var label_iterations: Array

func _enter_tree() -> void:
	var label_instance = value_label.instantiate()
	
	label_instance.text_value = label_text_value
	label_instance.text_key = label_text_key
	label_instance.iterations = label_iterations
	
	add_child(label_instance)
	return
