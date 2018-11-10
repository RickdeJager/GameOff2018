extends Area2D

var offset
var root
var moving = false

func _ready():
	root = get_tree().get_root().get_node("Root")

func clickedThis(coord):
		var space = get_world_2d().get_direct_space_state()
		var results = space.intersect_point(coord, 1, [], 2147483647)
		return len(results) > 0 and results[0]['collider'] == self
	
func _input(event):
	# Sorry for the spaghetti here :(
	if event is InputEventMouse and moving:
		global_position = get_global_mouse_position() + offset
		
	if not event is InputEventMouseButton:
		return
		
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		if not moving and clickedThis(get_global_mouse_position()):
			moving = true
			offset = global_position - get_global_mouse_position()
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and not event.is_pressed():
		moving = false