extends Node2D

const GRID_SIZE = 64
const SENSE_GRID_SIZE = 3
var screenSize
var parent
var camera

var senseBools

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	parent = get_parent()
	camera = parent.get_node("PlayerCamera")
	screenSize = get_viewport_rect().size
	senseBools = sense()

func _draw():
	var inv = get_global_transform().inverse()
	draw_set_transform(inv.get_origin(), inv.get_rotation(), inv.get_scale())
	var center = camera.get_camera_screen_center()
	var basePos = center - screenSize/2 + Vector2(50, 50)
	var offset = 30
	for i in range(len(senseBools)):
		for j in range(len(senseBools[i])):
			var pos = basePos + Vector2(i*offset, j*offset)
			var color = "#e2e2e2"
			if senseBools[i][j]:
				color = "#ff0000"
			draw_circle(pos, 5, Color(color))

func _process(delta):
	senseBools = sense()
	update()

func sense():
	var space = parent.get_world_2d().get_direct_space_state()
	var senseBools = []
	for i in range(1, SENSE_GRID_SIZE+1):
		senseBools.append([])
		for j in range(-SENSE_GRID_SIZE/2, SENSE_GRID_SIZE/2 + 1):
			var coord = Vector2(parent.global_position) + Vector2(i * GRID_SIZE, j * GRID_SIZE)
			#Get items at this coord, limit '1', 2147483647 is the layer value
			var results = space.intersect_point(coord, 1, [], 2147483647)
			#Add true if it is a collider, otherwise false
			senseBools[i-1].append(len(results) > 0 and results[0].has("collider"))
	
	return senseBools