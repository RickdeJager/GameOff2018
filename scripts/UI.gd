extends PanelContainer

var screenSize
var camera
var root
var beenRunning = true

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	camera = get_parent().get_node("Player/PlayerCamera")
	root = get_tree().get_root().get_node("Root")
	screenSize = get_viewport_rect().size

func _process(delta):
	if root.running:
		if not beenRunning:
			camera.offset = Vector2(0, 0)
			beenRunning = true
	else:
		if beenRunning:
			camera.offset = rect_global_position - camera.get_camera_screen_center() + screenSize/2
			beenRunning = false