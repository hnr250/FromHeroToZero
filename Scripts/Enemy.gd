extends Node

var POWER = 1000;
var VELOCITY = 0;
var is_enemy = true;


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