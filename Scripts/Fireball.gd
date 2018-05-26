# Fireball.gd
extends Area2D

const FIREBALL_SPEED = 200
var speed_x = 1
var speed_y = 0

func _ready():
	set_process(true)

func _process(delta):
	var motion = Vector2(speed_x, speed_y) * FIREBALL_SPEED
	global_position = global_position + motion * delta

func _on_VisibilityNotifier2D_exit_screen():
	queue_free()

func _on_Fireball_area_enter( area ):
	queue_free()
	area.queue_free()
	
#func body_entered( area ):
#	queue_free()
#	area.queue_free()