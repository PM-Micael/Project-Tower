extends Node

# Signal emitted when login is successful
signal login_successful(user_id: String, id_token: String, refresh_token: String)
signal login_failed(error_message: String)

# Hardcoded credentials for debugging - REMOVE BEFORE PRODUCTION!
const DEBUG_EMAIL = "fransisco7117@gmail.com"
const DEBUG_PASSWORD = "Micael123"

# Firebase configuration - replace with your Firebase project details
const FIREBASE_API_KEY = "AIzaSyAuPAWu3yklBAXdIpKQ_q-YAwiADg2q2x0"

var http_request: HTTPRequest

func _ready():
	# Create HTTPRequest node
	http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(_on_request_completed)

# Call this function to perform login
func login():
	# Ensure http_request is initialized
	if http_request == null:
		_initialize_http_request()
	
	print()
	print("Attempting Firebase login with hardcoded credentials...")
	_perform_firebase_login(DEBUG_EMAIL, DEBUG_PASSWORD)

# Optional: Login with custom credentials
func login_with_credentials(email: String, password: String):
	# Ensure http_request is initialized
	if http_request == null:
		_initialize_http_request()
	
	print()
	print("Attempting Firebase login with custom credentials...")
	_perform_firebase_login(email, password)

func _initialize_http_request():
	http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(_on_request_completed)

func _perform_firebase_login(email: String, password: String):
	var url = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=" + FIREBASE_API_KEY
	
	var body = JSON.stringify({
		"email": email,
		"password": password,
		"returnSecureToken": true
	})
	
	var headers = [
		"Content-Type: application/json; charset=UTF-8"
	]
	
	var error = http_request.request(url, headers, HTTPClient.METHOD_POST, body)
	
	if error != OK:
		print("HTTP Request error: ", error)
		emit_signal("login_failed", "HTTP Request error: " + str(error))

func _on_request_completed(result, response_code, headers, body):
	var json = JSON.new()
	var parse_result = json.parse(body.get_string_from_utf8())
	
	if parse_result == OK:
		var response = json.data
		var token = response.get("idToken", "")
		
		if response_code == 200:
			print("✓ Login successful!")
			var user_id = response.get("localId", "")
			print("User ID: ", user_id)
			print("ID Token: ", token.substr(0, 50), "...")
			print("Email: ", response.get("email", "N/A"))
			
			# Get the tokens
			var id_token = response.get("idToken", "")
			var refresh_token = response.get("refreshToken", "")
			
			# Emit the success signal with user data
			emit_signal("login_successful", user_id, id_token, refresh_token)
			
		else:
			print("✗ Login failed!")
			print("Response code: ", response_code)
			var error_message = response.get("error", {}).get("message", "Unknown error")
			print("Error: ", error_message)
			emit_signal("login_failed", error_message)
	else:
		print("Failed to parse JSON response")
		emit_signal("login_failed", "Failed to parse JSON response")
