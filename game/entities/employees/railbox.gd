extends Area2D

var pawn = 0
var transferring: bool = false
var next_rail = 0

func _ready():
	pawn = get_parent()

func _on_railbox_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.is_in_group("rail"):
		if pawn.falling:
			pawn.falling = false
			pawn.vel = Vector2(0,0)
			var line = area.shape_owner_get_owner(area_shape_index)
			pawn.rail_a = (line.shape.b.y - line.shape.a.y)/(line.shape.b.x - line.shape.a.x)
			pawn.rail_b = line.shape.a.y - pawn.rail_a * line.shape.a.x
		else:
			next_rail = area.shape_owner_get_owner(area_shape_index)
			transferring = true


func _on_railbox_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	if area.is_in_group("rail"):
		if transferring:
			var line = next_rail
			pawn.rail_a = (line.shape.b.y - line.shape.a.y)/(line.shape.b.x - line.shape.a.x)
			pawn.rail_b = line.shape.a.y - pawn.rail_a * line.shape.a.x
			transferring = false
		else:
			pawn.falling = true
