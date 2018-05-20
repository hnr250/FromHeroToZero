extends KinematicBody2D

var STATS = {"power": 750, "velocity":2}

var ROTATION_ANGLE = 0

func _ready():
	add_to_group("player")

func _physics_process(delta):
	var vector = _move_player()
	_update_player_texture(vector)

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

	movement_vector = Vector2(horizontal_movement*STATS.velocity,vertical_movement*STATS.velocity)
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
			STATS = collider.do_collide(STATS)
		if(collider.is_in_group("pickup")):
			STATS = collider.do_collide(STATS)
			