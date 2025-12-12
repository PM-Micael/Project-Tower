extends Node

func load_json(path: String) -> Dictionary:
	var file := FileAccess.open(path, FileAccess.READ)
	if not file:
		push_error("Failed to open file: " + path)
		return {}
	
	var text := file.get_as_text()
	var result : Dictionary = JSON.parse_string(text)
	
	if result == null:
		push_error("JSON parsing failed for: " + path)
		return {}
	
	return result
