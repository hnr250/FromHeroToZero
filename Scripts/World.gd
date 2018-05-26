extends Node2D

onready var player = get_node("player")
onready var label = get_node("GUI/Label")

func _ready():
	pass

func _process(delta):
	_update_GUI()
	
	if player.STATS.power > 10000:
		label.text = "GAME OVER - TOO POWERFUL TO HANDLE"
		get_tree().paused = true
	if player.STATS.power < 0:
		label.text = "ZERO REACHED - YOU WIN!"
		get_tree().paused = true
	
func _update_GUI():
	#var player = get_node("player")
	#var label = get_node("KinematicBody2D/Camera2D/Label")
	#var label = get_node("GUI/Label")
	
	label.text = _get_power_text(player)

func _get_power_text(player):
	var POWER = player.STATS.power
	var VELOCITY = player.STATS.velocity
	if POWER <= 9000:
		return "POWER: " + str(POWER) + "\nVELOCITY: " + str(VELOCITY)
	else:
		return "POWER: 9000+"
