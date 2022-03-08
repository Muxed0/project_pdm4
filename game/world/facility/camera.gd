extends Camera2D

var dragging = false
var previous_mouse_pos = Vector2(0,0)

func _ready():
	pass

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 2:
			if event.is_pressed():
				previous_mouse_pos = self.zoom.x * event.position + self.position
				dragging = true
			else:
				dragging = false
		elif event.button_index == 4:
			self.zoom *= 0.9
		elif event.button_index == 5:
			self.zoom *= 1.1
	elif event is InputEventMouseMotion:
		if dragging:
			self.position = (previous_mouse_pos - self.zoom.x * event.position)
