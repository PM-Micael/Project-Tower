extends Control   # or whatever your root node is

func _ready():
	var data = Global.load_json("res://Files/test.json")
	if data:
		print("Loaded JSON:", data)
		print(data["core"]["health"])
