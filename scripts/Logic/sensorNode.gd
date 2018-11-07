extends "res://scripts/Inventory/moveableItem.gd"

var outputNodes = []

func _ready():
	# ! This requires children to be in order in the scene.
	for child in get_children():
		if child is Area2D:
			outputNodes.append(child)

func _process(delta):
	var sensors = get_tree().get_root().get_node("Root").player.get_node("sensors")
	for i in range(len(outputNodes)):
		outputNodes[i].setValue(sensors.senseBools[i%3][i/3])