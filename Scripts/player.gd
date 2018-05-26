extends KinematicBody2D

var STATS = {"power": 5000, "velocity":2}

var ROTATION_ANGLE = 0
var SPINBALL_ENABLED = true
var timeout = 1
var timer = 0
var FIREBALL = preload("res://Objects/Fireball.tscn")

func _ready():
	add_to_group("player")

func _physics_process(delta):
	var vector = _move_player()
	_update_player_texture(vector)
	timer+=delta
	if(timer>timeout):
		_process_powers()
		timer = 0

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
			get_node("enemy_sound").play()
			STATS = collider.do_collide(STATS)
		if(collider.is_in_group("pickup")):
			get_node("pickup_sound").play()
			STATS = collider.do_collide(STATS)
		if(collider.is_in_group("trap")):
			get_node("trap_sound").play()
			STATS = collider.do_collide(STATS)
			
func _process_powers():
	if STATS.power >5500: #fireballs
		get_node("fireball_sound").play()
		var fireball = FIREBALL.instance()
		fireball.global_rotation_degrees = 180
		var fireball_w = FIREBALL.instance()
		fireball_w.speed_x = -1
		var fireball_n = FIREBALL.instance()
		fireball_n.speed_x = 0
		fireball_n.speed_y = 1
		fireball_n.global_rotation_degrees = 270
		var fireball_s = FIREBALL.instance()
		fireball_s.speed_x = 0
		fireball_s.speed_y = -1
		fireball_s.global_rotation_degrees = 90
		get_parent().add_child(fireball)
		get_parent().add_child(fireball_w)
		get_parent().add_child(fireball_n)
		get_parent().add_child(fireball_s)
		fireball.global_position = global_position
		fireball_w.global_position = global_position
		fireball_n.global_position = global_position
		fireball_s.global_position = global_position
#	if STATS.power >4000: #enable spinball
#		SPINBALL_ENABLED = true
#	if STATS.power < 4000: #disable spinball	
#		SPINBALL_ENABLED = false