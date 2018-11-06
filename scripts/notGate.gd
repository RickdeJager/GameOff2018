extends "res://scripts/moveableItem.gd"

var inputNode
var outputNode

func _ready():
	inputNode = get_node("input")
	outputNode = get_node("output")

func _process(delta):
	var value = inputNode.value
	outputNode.setValue(not value)