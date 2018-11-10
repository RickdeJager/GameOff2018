extends Node

var lastInput
var dragging = false
var andGate
var orGate
var notGate
var sensorNode
var screenSize

func _ready():
	andGate = load("res://scenes/Gates/andGate.tscn")
	orGate = load("res://scenes/Gates/orGate.tscn")
	notGate = load("res://scenes/Gates/notGate.tscn")
	sensorNode = load("res://scenes/Inputs/sensorNode.tscn")
	screenSize = get_viewport().size

func pickASpot():
	var offset = Vector2(300, 150)
	var x = rand_range(offset.x, screenSize.x - offset.x)
	var y = rand_range(offset.y, screenSize.y - offset.y)
	return Vector2(x, y)

func setGates(numAnd, numOr, numNot, addSensors = false):
	for child in get_children():
		if not "term" in child.name.to_lower():
			child.queue_free()
		else:
			child.input.value = false
			child.input.connection = null
			
	for i in range(numAnd):
		var instance = andGate.instance()
		instance.position = pickASpot()
		add_child(instance)
		
	for i in range(numOr):
		var instance = orGate.instance()
		instance.position = pickASpot()
		add_child(instance)
		
	for i in range(numNot):
		var instance = notGate.instance()
		instance.position = pickASpot()
		add_child(instance)
	
	if addSensors:
		var instance = sensorNode.instance()
		instance.position = pickASpot()
		add_child(instance)
	