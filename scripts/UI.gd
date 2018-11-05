extends PanelContainer

var screenSize
var camera
var root

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	camera = get_parent().get_node("Player/PlayerCamera")
	root = get_tree().get_root().get_node("Root")
	screenSize = get_viewport_rect().size
	rect_position = screenSize/2
	rect_size = screenSize
	hide()

func _process(delta):
	if root.running:
		hide()
	else:
		show()
	var center = camera.get_camera_screen_center()
	rect_position = center - screenSize/2
	rect_size = screenSize

