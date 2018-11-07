extends Area2D

var root

func _ready():
	root = get_tree().get_root().get_node("Root")

func _on_finish_body_entered(body):

	var groups = body.get_groups()
	# we're only interested in collisions with the player
	if not groups.has("player"):
		return

	root.startNextLevel()