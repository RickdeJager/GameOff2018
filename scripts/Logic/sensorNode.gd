extends "res://scripts/Inventory/moveableItem.gd"

var sensors
var outputNodes = []

func _ready():
	# ! This requires children to be in order in the scene.
	for child in get_children():
		if child is Area2D:
			outputNodes.append(child)
			
	sensors = get_tree().get_root().get_node("Root").get_node("player").get_node("sensors")

func _process(delta):
	for i in range(len(outputNodes)):
		outputNodes[i].setValue(sensors.senseBools[i%3][i/3])