extends Node2D

var selected = false
var falling = true
var wandering = true
var base_walking_speed = 2
var accel = 750
var vel = Vector2(0,0)

var rail_a: float = 0
var rail_b: float = 0

func _process(delta):
	if falling:
		vel = Vector2(vel[0], vel[1] + accel * delta)
		position = Vector2(position[0], position[1] + vel[1] * delta + (accel * delta * delta) /2)
	if not falling:
		position.y = rail_a * position.x + rail_b
	if wandering and not falling:
		position.x += base_walking_speed * sqrt(pow(10,rail_a))
