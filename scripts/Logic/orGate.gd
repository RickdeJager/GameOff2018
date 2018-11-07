extends "res://scripts/Inventory/moveableItem.gd"

var inputNodeA
var inputNodeB
var outputNode

func _ready():
	inputNodeA = get_node("inputNodeA")
	inputNodeB = get_node("inputNodeB")
	outputNode = get_node("outputNode")

func _process(delta):
	var valueA = inputNodeA.value
	var valueB = inputNodeB.value
	outputNode.setValue(valueA or valueB)