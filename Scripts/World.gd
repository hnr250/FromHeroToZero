extends Node2D

func _ready():
	pass

func _process(delta):
	_update_GUI()
	
func _update_GUI():
	var player = get_node("KinematicBody2D")
	var label = get_node("Label")
	
	label.text = _get_power_text(player)

func _get_power_text(player):
	var POWER = player.POWER
	if POWER <= 9000:
		return "POWER: " + str(POWER)
	else:
		return "POWER: 9000+"