extends PanelContainer

var screenSize
var root
var beenRunning = true

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	root = get_tree().get_root().get_node("Root")
	screenSize = get_viewport_rect().size

func _process(delta):
	var camera = root.player.get_node("camera")
	if root.running:
		if not beenRunning:
			camera.offset = Vector2(0, 0)
			beenRunning = true
	else:
		if beenRunning:
			camera.offset = rect_global_position - camera.get_camera_screen_center() + screenSize/2
			beenRunning = false