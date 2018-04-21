extends KinematicBody2D

var VELOCITY = 2
var POWER = 750

var ROTATION_ANGLE = 0

func _physics_process(delta):
	var vector = _move_player()
	_update_player_texture(vector)
	
	_update_power()

func _update_power():
	#TODO: create proper updating algorithm
	POWER = POWER + 5
	if POWER <= 9000:
		VELOCITY = VELOCITY + 0.001
	
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
		horizontal_movement = horizontal_movement /1.4143
		vertical_movement = vertical_movement /1.4143

	movement_vector = Vector2(horizontal_movement*VELOCITY,vertical_movement*VELOCITY)
	var collision = move_and_collide(movement_vector)
	checkCollision(collision)
			
	return movement_vector
	
func _update_player_texture(vector):
	if vector.x == 0 && vector.y == 0:
		return
	var angle = atan2(deg2rad(vector.x),-deg2rad(vector.y))
	rotate(angle - ROTATION_ANGLE)
	ROTATION_ANGLE = angle
	
func checkCollision(collision):
	if(collision):
		var collider = collision.collider
		if(collider.is_in_group("enemy")):
			POWER = POWER - collider.POWER
			collider.queue_free()
		if(collider.is_in_group("pickup")):
			POWER = POWER + collider.POWER_MODIFIER
			collider.do_collide()
			