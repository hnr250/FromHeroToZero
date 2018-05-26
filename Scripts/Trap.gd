extends StaticBody2D

var POWER_MODIFIER = -1000
var VELOCITY_MODIFIER = 0.1

func _ready():
	randomize()
	add_to_group("pickup");
	_generate_stats()
	
func _generate_stats():	
	POWER_MODIFIER = -100 * (1 + randi() % 5)

func do_collide(player):
	#update stats
	player.power = player.power + POWER_MODIFIER
	player.velocity = player.velocity - VELOCITY_MODIFIER
	
	#despawn
	var spawner = get_tree().get_root().get_node("Tileset/Spawner")
	spawner.traps = spawner.traps - 1
	queue_free()
	
	return player
