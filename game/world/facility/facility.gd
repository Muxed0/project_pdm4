extends Node2D

var camera = 0
var window_size = 0

var employee = preload("res://entities/employees/employee.tscn")
var employee_instance = 0

var pawn = preload("res://entities/employees/pawn.tscn")
var pawn_instance = 0
var pawn_select_

# Called when the node enters the scene tree for the first time.
func _ready():
	camera = get_node("camera")
	window_size = Vector2(get_viewport().get_size()[0], get_viewport().get_size()[1])

func _input(event):
	if event is InputEventKey:
		if event.pressed and not event.is_echo():
			if event.keycode == KEY_EQUAL:
				add_employee()
			elif event.keycode == KEY_P:
				add_pawn()

func add_employee():
	employee_instance = employee.instantiate()
	self.add_child(employee_instance)
	$selection_tool.connect("selection_reset", Callable(employee_instance,"_on_selection_tool_selection_reset"))
	employee_instance.position =  camera.zoom.x * (get_viewport().get_mouse_position()-window_size/2) + camera.position

func add_pawn():
	pawn_instance = pawn.instantiate()
	self.add_child(pawn_instance)
	$selection_tool.connect("selection_reset", Callable(pawn_instance.get_node("hitbox"), "_on_selection_tool_selection_reset"))
	pawn_instance.position =  camera.zoom.x * (get_viewport().get_mouse_position()-window_size/2) + camera.position
