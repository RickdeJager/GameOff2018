extends KinematicBody2D


func _ready():
	pass


func _on_hitbox_area_body_entered(body):
	var groups = body.get_groups()
	
	print(groups)
	
	# we're only interested in collisions with the player
	if not groups.has("player"):
		return
	
	# kill player
	body.queue_free()
	
