extends Node

func _ready():
	# Passes a player pointer to the root node
	get_node("..").player = get_node("player")
	randomize()
	
func _process(delta):
	# If we've been falling for too long, restart the level
	if get_node("player").motion.y > 1500:
		get_node("..").restartLevel()