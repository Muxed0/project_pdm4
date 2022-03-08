extends Area2D

var selected = false
var falling = true
var accel = 1000
var vel = Vector2(0,0)

func _process(_delta):
	if selected:
		$basic_sprite.frame = 1
	else:
		$basic_sprite.frame = 0
		
func _physics_process(delta):
	if falling:
		vel = Vector2(vel[0], vel[1] + accel * delta)
		position = Vector2(position[0], position[1] + vel[1] * delta + (accel * delta * delta) /2)

func _on_selection_tool_selection_reset():
	selected = false

func _on_employee_area_entered(area):
	if area.is_in_group("selection"):
		selected = true
	if area.is_in_group("rail"):
		falling = false
