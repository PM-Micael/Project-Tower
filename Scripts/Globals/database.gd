extends Node

var http := HTTPRequest.new()
var firebase_url := "https://project-tower-ea600-default-rtdb.firebaseio.com/"

func get_users():
	add_child(http)
	http.request_completed.connect(_on_request_completed)
	
	# Example usage: fetch data from "test" node
	get_data("users")

# --- READ / GET ---
func get_data(path: String) -> void:
	var url = firebase_url + path + ".json"
	http.request(url, [], HTTPClient.METHOD_GET)

# --- CALLBACK ---
func _on_request_completed(result: int, response_code: int, headers: Array, body: PackedByteArray) -> void:
	
	
	print("Response code:", response_code)
	print("Body:", body.get_string_from_utf8())
