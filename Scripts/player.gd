extends KinematicBody2D

var VELOCITY = 2

func _physics_process(delta):
	_move_player()
    
func _move_player():
	var horizontal_movement = 0
	var vertical_movement = 0
	var movement_vector = Vector2(0,0)

	if Input.is_action_pressed("ui_left"):
		horizontal_movement = -1
	elif Input.is_action_pressed("ui_right"):
		horizontal_movement = 1

	if Input.is_action_pressed("ui_up"):
		vertical_movement = -1
	elif Input.is_action_pressed("ui_down"):
		vertical_movement = 1
    
	if horizontal_movement * horizontal_movement == vertical_movement * vertical_movement:
		horizontal_movement = horizontal_movement /1.4142
		vertical_movement = vertical_movement /1.4142

	movement_vector = Vector2(horizontal_movement*VELOCITY,vertical_movement*VELOCITY)
	move_and_collide(movement_vector)