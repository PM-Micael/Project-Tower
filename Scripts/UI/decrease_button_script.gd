extends Button

func _pressed():
	# Find the ValueLabel sibling automatically
	var label = get_parent().get_node_or_null("ValueLabel") as ValueLabel
	if label:
		label.decrement()
	else:
		print("Could not find ValueLabel sibling!")
