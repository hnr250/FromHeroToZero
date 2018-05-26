extends StaticBody2D

var POWER_MODIFIER = 1000
var VELOCITY_MODIFIER = 1.4

func _ready():
	add_to_group("pickup");
	pass

func do_collide(player):
	#update stats
	player.power = player.power + POWER_MODIFIER
	player.velocity = player.velocity + VELOCITY_MODIFIER
	
	#despawn
	var spawner = get_tree().get_root().get_node("Tileset/Spawner")
	spawner.pickups = spawner.pickups - 1
	queue_free()
	
	return player