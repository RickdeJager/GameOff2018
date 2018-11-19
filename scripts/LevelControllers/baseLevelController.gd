extends Node

var root
var done = false
var editor

##################################################
# What Gates/sensors should this level have?     #
##################################################
export (int) var numNotGates
export (int) var numAndGates
export (int) var numOrGates
export (bool) var showSensors = false

func _ready():
	# Passes a player pointer to the root node
	root = get_tree().get_root().get_node("Root")
	root.player = get_node("player")
	editor = get_node("../../../c2/Viewport2/UI/Main/Editor")
	randomize()
	
func init(restart):
	if (restart):	# If were restarting the level, keep the gates
		done = true
	
func _process(delta):
	# If we've been falling for too long, restart the level
	if get_node("player").motion.y > 1500:
		root.restartLevel()

	# Will only be called once
	if not done:
		editor.setGates(numAndGates, numOrGates, numNotGates, showSensors)
		done = true