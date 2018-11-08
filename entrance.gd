extends Node2D

export (bool) var createDebugPlayers = false
var player = null

func createPlayer():
	if self.player != null:
		return
	
	# TODO: fix this path. It'll probably cause problems if we move stuff around
	self.player = load("res://sprites/player/player.tscn")
	self.player.instance()

func _ready():
	self.createPlayer()
