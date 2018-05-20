extends KinematicBody2D

var POWER = 1000;
var VELOCITY = 2;
var is_enemy = true;
var PLAYER_POWER_THRESHOLD = 1000


func _ready():
	pass

func do_collide(player):
	#update stats
	player.power = player.power - POWER
	
	#despawn
	var spawner = get_tree().get_root().get_node("Tileset/Spawner")
	spawner.enemies = spawner.enemies - 1
	queue_free()
	
	return player
	
func _physics_process(delta):
	var movement_vector = _move_enemy()
	var collision = move_and_collide(movement_vector)
	_check_collision(collision)
	
func _move_enemy():
	var player = get_tree().get_root().get_node("Tileset/player")
	var power = player.STATS.power
	var player_position = player.get_global_position()
	if power > PLAYER_POWER_THRESHOLD:
		return _get_closer_position(player_position)
	else:
		return _get_further_position(player_position)
		
func _get_closer_position(player_position):
	var horizontal_movement = 0
	var vertical_movement = 0
	if global_position.x > player_position.x:
		horizontal_movement = -1
	else:
		horizontal_movement = 1
		
	if global_position.y > player_position.y:
		vertical_movement = -1
	else:
		vertical_movement = 1
		
	return Vector2(horizontal_movement * VELOCITY, vertical_movement * VELOCITY)
	
func _get_further_position(player_position):
	var horizontal_movement = 0
	var vertical_movement = 0
	if global_position.x > player_position.x:
		horizontal_movement = 1
	else:
		horizontal_movement = -1
		
	if global_position.y > player_position.y:
		vertical_movement = 1
	else:
		vertical_movement = -1
		
	return Vector2(horizontal_movement * VELOCITY, vertical_movement * VELOCITY)
		
func _check_collision(collision):
	if(collision):
		var collider = collision.collider
		if(collider.is_in_group("player")):
			do_collide(collider.STATS)

