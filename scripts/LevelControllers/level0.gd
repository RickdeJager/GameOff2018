extends "res://scripts/LevelControllers/baseLevelController.gd"

var editor
var done = false

##################################################
# What Gates/sensors should this level have?     #
##################################################
var numNotGates = 1
var numAndGates = 0
var numOrGates = 0
var showSensors = false

func _ready():
	editor = get_node("../UI/Main/Editor")
	
func _process(delta):
	# Setting up gates requires other ready functions to have passed already
	if not done:
		editor.setGates(numAndGates, numOrGates, numNotGates, showSensors)
		done = true