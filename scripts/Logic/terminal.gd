extends "res://scripts/Inventory/moveableItem.gd"

var action
var player
var input

func _ready():
	# This is horrible practice and will limit us to a maximum of one term of each type per scene.
	# but it does simplify things for now so ¯\_(ツ)_/¯
	action = name[-1]
	input = get_node("inputNode")
	
func _process(delta):
	if input.value:
		player = get_tree().get_root().get_node("Root").player
		player.addAction(action)

