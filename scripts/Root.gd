extends Node

var running = true
var player
var currentLevel = 0

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		running = not running

func startNextLevel():
	loadLevel(currentLevel+1)
		
func loadLevel(levelID):
	var nextScene = load("res://scenes/Levels/Level"+str(levelID)+".tscn")
	if nextScene:
		#Unload current level
		for child in get_node("c/c1/Viewport").get_children():
			if "level" in child.name.to_lower():
				child.queue_free()
		var nextLevel = nextScene.instance()
		nextLevel.name = "level"+str(levelID)
		get_node("c/c1/Viewport").add_child(nextLevel)
		currentLevel = levelID
		
	# You've reached the last level! not sure what to do...
	# Let's launch 'm into space
	else:
		player.motion.y -= 2000
		
func restartLevel():
	loadLevel(currentLevel)