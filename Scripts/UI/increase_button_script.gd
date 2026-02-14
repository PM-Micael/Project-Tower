extends Button

func _pressed():
	var label = get_parent().get_node_or_null("ValueLabel") as ValueLabel
	if label:
		label.increment()
	else:
		print("Could not find ValueLabel sibling!")
