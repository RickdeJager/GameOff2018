extends Area2D

var connection
var value = false
var editor
var root

func _ready():
	root = get_tree().get_root().get_node("Root")
	editor = get_node("../..")
	print("Initialised input")
	
func _draw():
	if connection:
		var to = connection.global_position - global_position
		draw_line(Vector2(0, 0), to , Color("#ffff00"), 1.0)
	
func _input(event):
	if not event is InputEventMouseButton or root.running:
		return 
	else:
		print(get_parent().name)
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and not event.is_pressed() and editor.dragging:
		#This may break in the future!
		var space = get_world_2d().get_direct_space_state()
		var results = space.intersect_point(get_global_mouse_position(), 1, [], 2147483647)
		if len(results) > 0 and results[0]['collider'] == self and editor.lastInput:
			#Don't connect the gate input to it's own output
			if editor.lastInput.get_parent() == get_parent():
				return
			setConnection(editor.lastInput)
			editor.lastInput = null
			editor.dragging = false
			update()

func setConnection(newConnection):
	connection = newConnection
	
func setValue(newValue):
	value = newValue
