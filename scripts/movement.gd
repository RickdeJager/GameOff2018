extends KinematicBody2D

const UP = Vector2(0, -1)
const SPEED = 300
const JUMP_SPEED = 500
const GRAVITY = 17
var motion = Vector2()
var sensors
const code = """True > R
NOT 7 OR 4 > S
3 AND NOT 5 AND 7 > L"""

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	sensors = get_node("Sensors")
	print(sensors.screenSize)
	
func interpret(CodeString):
	var senseBools = sensors.senseBools
	var actions = []
	for line in CodeString.split('\n'):
		var condition = line.split(" > ")[0].split(' ')
		var action = line.split(" > ")[1]
		#Evaluate the condition, if true add the action to a list.
		#This does not support brackets yet, be can be done using recursion
		#First fill in values
		for index in range(len(condition)):
			var word = condition[index]
			if int(word) > 0:
				var col = (int(word) - 1) / 3
				var row = (int(word) - 1) % 3
				condition[index] = str(senseBools[row][col])
				
		#Handle negations
		var index = 0
		while index < len(condition) - 1:
			var word = condition[index]
			if  word == "NOT":
				if condition[index + 1] == "NOT":
					condition.remove(index)
					condition.remove(index)
					index -= 1
				elif condition[index + 1] == "True":
					condition.remove(index)
					condition[index] = "False"
				elif condition[index + 1] == "False":
					condition.remove(index)
					condition[index] = "True"
				else:
					print("mistake in not function")
			index += 1
			
		#Handle AND / OR
		index = 1
		while index < len(condition) - 1:
			var word = condition[index]
			var prevWord = condition[index - 1]
			var nextWord = condition[index + 1]
			if  word == "AND" or word == "OR":
				if (word == "AND" and prevWord == "True" and nextWord == "True") or word == "OR" and (prevWord == "True" or nextWord == "True"):
					condition[index+1] = "True"
				else:
					condition[index+1] = "False"
				condition.remove(index-1)
				condition.remove(index-1)
				index -= 1
			index += 1
		#See what this evaluates to
		if len(condition) == 1 and condition[0] == "True":
			actions.append(action)
	return actions

func _physics_process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	var nextMotion = Vector2()
	var actions = interpret(code)
	if actions.has("L"):
		nextMotion.x -= 1
	if actions.has("R"):
		nextMotion.x += 1
	#Enter or space by default
	if actions.has("S") and is_on_floor():
		nextMotion.y -= 1
		interpret(code)
		
	#Apply current motion
	motion.x = SPEED * nextMotion.x
	motion.y += JUMP_SPEED * nextMotion.y 
	#Apply gravity
	motion.y += GRAVITY
	
	motion = move_and_slide(motion, UP)