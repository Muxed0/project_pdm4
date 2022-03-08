extends Area2D

var outline = 0
var hitbox = 0
var camera = 0 

var drawing = false
var window_size = Vector2(0,0)
var starting_point = Vector2(0,0)
var user_mouse_pos = Vector2(0,0)
var selected_pawns = 0

signal selection_reset

func _ready():
	outline = get_node("selection_outline")
	hitbox = get_node("selection_hitbox")
	camera = get_node("../camera")
	window_size = Vector2(get_viewport().get_size()[0], get_viewport().get_size()[1])
	pos_reset(hitbox)

func _input(event):
	if event is InputEventMouseButton and event.button_index == 1:
		if event.is_pressed():
			emit_signal("selection_reset")
			selected_pawns = 0
			starting_point = camera.zoom * (event.position - window_size/2) + camera.position
			hitbox.position = starting_point
			hitbox.shape.extents = Vector2(10,10)
			
			outline.points[0] = starting_point
			drawing = true
		elif not event.is_pressed():
			pos_reset(hitbox)
			hitbox.shape.extents = Vector2(0,0)
			outline.hide()
			for i in outline.points.size():
				outline.points[i] = Vector2(0,0)
			drawing = false
			
	if event is InputEventMouseMotion and drawing:
		user_mouse_pos = camera.zoom * (event.position - window_size/2) + camera.position
		
		hitbox.shape.extents = Vector2(user_mouse_pos - starting_point)/2
		hitbox.position = Vector2(starting_point + hitbox.shape.extents)
		outline.show()
		outline.width = camera.zoom.x * 2
		outline.points[1] = Vector2(user_mouse_pos[0],outline.points[0][1])
		outline.points[2] = user_mouse_pos
		outline.points[3] = Vector2(outline.points[0][0],user_mouse_pos[1])
		outline.points[4] = outline.points[0]

func pos_reset(hitbox):
	hitbox.position = Vector2(0,0)
	hitbox.shape.extents = Vector2(0,0)


func _on_selection_tool_area_entered(area):
	if area.is_in_group("pawn"):
		selected_pawns += 1
