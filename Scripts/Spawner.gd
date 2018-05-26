extends Area2D

var timer = 0
var timeout = 1
var enemies = 0
var max_enemites = 12
var pickups = 0
var max_pickups = 10
var traps = 0
var max_traps = 5
var enemy_object = load("res://Objects/enemy.tscn")
var pickup_object = load("res://Objects/unknownPickup.tscn")
var trap_object = load("res://Objects/trap.tscn")

func _ready():
	randomize()
	pass

func _physics_process(delta):
	timer+=delta
	if(timer>timeout):
		var what_to_spawn = randi()%3
		if what_to_spawn == 0 && enemies < max_enemites:
			var new_enemy = enemy_object.instance()
			new_enemy.position = get_random_spawn_position()
			$"../Enemies".add_child(new_enemy)
			enemies = enemies + 1
			timer = 0
		if what_to_spawn == 1 && pickups < max_pickups:
			var new_pickup = pickup_object.instance()
			new_pickup.position = get_random_spawn_position()
			$"../Pickups".add_child(new_pickup)
			pickups = pickups + 1
			timer = 0
		if what_to_spawn == 2 && traps < max_traps:
			var new_pickup = trap_object.instance()
			new_pickup.position = get_random_spawn_position()
			$"../Pickups".add_child(new_pickup)
			traps = traps + 1
			timer = 0
	
func get_random_spawn_position():
	var children = get_children()
	var selected_spawn_point = get_child(randi()%get_child_count());
	var shape = selected_spawn_point.shape.extents
	return selected_spawn_point.global_position+Vector2(rand_range(-shape.x,shape.x),rand_range(-shape.y,shape.y))
