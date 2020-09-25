extends VBoxContainer


func _input_event(viewport, event):
	if (event.is_pressed() and event.button_index == BUTTON_LEFT):
		print("Wow, a left mouse click")
