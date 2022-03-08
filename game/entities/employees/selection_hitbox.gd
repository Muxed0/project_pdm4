extends Area2D

var selected = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_selection_tool_selection_reset():
	selected = false
	$"../basic_sprite".frame = 0

func _on_selection_hitbox_area_entered(area):
	if area.is_in_group("selection"):
		selected = true
		$"../basic_sprite".frame = 1

