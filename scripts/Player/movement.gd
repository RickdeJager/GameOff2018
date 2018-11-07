extends KinematicBody2D

const UP = Vector2(0, -1)
const SPEED = 300
const JUMP_SPEED = 524
const GRAVITY = 17
const REQUIRED_GROUND_TIME = 0.1 # Adds a 100 ms delay between hitting the ground and jumping again
var motion = Vector2()
var sensors
var actions = []
var groundTime = 0

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	sensors = get_node("sensors")
	
func addAction(action):
	actions.append(action)

func _physics_process(delta):
	if is_on_floor() and groundTime < REQUIRED_GROUND_TIME:
		groundTime += delta
	var root = get_tree().get_root().get_node("Root")
	if not root.running:
		return
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	var nextMotion = Vector2()

	if actions.has("L") or Input.is_action_pressed("ui_left"):
		nextMotion.x -= 1
	if actions.has("R") or Input.is_action_pressed("ui_right"):
		nextMotion.x += 1
	# Enter or space by default
	if (actions.has("S") or Input.is_action_pressed("ui_accept")) and is_on_floor() and groundTime >= REQUIRED_GROUND_TIME:
		nextMotion.y -= 1
		groundTime = 0
		
	# Apply current motion
	motion.x = SPEED * nextMotion.x
	motion.y += JUMP_SPEED * nextMotion.y 
	# Apply gravity
	motion.y += GRAVITY
	
	motion = move_and_slide(motion, UP)
	# Clear last frames actions
	actions = []
