extends Node2D

func _ready():
	pass

func _process(delta):
	_update_GUI()
	
func _update_GUI():
	var player = get_node("player")
	#var label = get_node("KinematicBody2D/Camera2D/Label")
	var label = get_node("GUI/Label")
	
	label.text = _get_power_text(player)

func _get_power_text(player):
	var POWER = player.STATS.power
	if POWER <= 9000:
		return "POWER: " + str(POWER)
	else:
		return "POWER: 9000+"
