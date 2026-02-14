extends Control   # or whatever your root node is

@export_category("Tier Selector")

@export var value_selector_scene: PackedScene

@export_group("Value Label")
@export var label_text_key: String
@export var label_text_value: String ## placeholder value
@export var label_iterations: Array


func _enter_tree() -> void:
	create_scene()

func create_scene():
	if value_selector_scene:
		var value_selector_instance = value_selector_scene.instantiate()
		
		value_selector_instance.label_text_key = label_text_key
		value_selector_instance.label_text_value = label_text_value
		value_selector_instance.label_iterations = label_iterations
		
		add_child(value_selector_instance)
