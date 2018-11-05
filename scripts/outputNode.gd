extends Area2D

var connection

var value = false
var editor
var root

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	root = get_tree().get_root().get_node("Root")
	editor = get_node("../..")
	
#func _process(delta):
#	if connection:
#		connection.setValue(value)
		
func setConnection(newConnection):
	connection = newConnection
	
func setValue(newValue):
	value = newValue
	
func _input(event):
	if not event is InputEventMouseButton or root.running:
		return 
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed() and not editor.dragging:
		#This may break in the future!
		var space = get_world_2d().get_direct_space_state()
		var results = space.intersect_point(get_global_mouse_position(), 1, [], 2147483647)
		if len(results) > 0 and results[0]['collider'] == self:
			editor.lastInput = self
			editor.dragging = true




