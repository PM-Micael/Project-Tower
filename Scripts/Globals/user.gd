extends Node

var user_id: String
var user_tag: String

# Main Menu
var selected_tier: int

# Current Round
var ongoing_round: bool
var tier: int
var wave: int
var game_speed: float

func get_data():
	return

func _ready():
	EmailAuth.login_successful.connect(_on_login_successful)
	EmailAuth.login_failed.connect(_on_login_failed)


func _on_login_successful(received_user_id: String, received_id_token: String, received_refresh_token: String):
	# Store the user ID
	user_id = received_user_id
	print("User global: User ID stored - ", user_id)
	
	# Add your custom logic here
	pass

func _on_login_failed(error_message: String):
	print("User global: Login failed - ", error_message)
	
	# Add your custom logic here
	pass
