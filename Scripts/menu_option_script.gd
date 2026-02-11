## The Child class of this class should instansiate the "init()" function.
## The init function shall contain "is_child_class = true" to comunicate that this is a class that is allowed to be instansiated.
## It should also set the "scene_path" of type string.
extends Label
class_name MenuOption

var is_child_class = false
var scene_path = "res://Scenes/Game.tscn"

func activate():
	var node_path := get_path()
	var scene_path := get_tree().current_scene.scene_file_path if get_tree().current_scene else "Unknown scene"

	assert(is_child_class,
		"❌ MenuOption base class was used directly!\n" +
		"This class is abstract and must be extended.\n\n" +
		"Node: " + str(node_path) + "\n" +
		"Scene: " + scene_path + "\n" +
		"You must override MenuOption.activate() in a child class."
	)

func _ready() -> void:
	activate()
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND

func _gui_input(event):
	open_scene(event)

func open_scene(event):
	if event is InputEventMouseButton \
	and event.pressed \
	and event.button_index == MOUSE_BUTTON_LEFT:
		get_tree().change_scene_to_file(scene_path)
