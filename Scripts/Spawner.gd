extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var timer = 0
var timeout = 1
var enemy_object = load("res://Objects/enemy.tscn")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	randomize()
	pass

func _physics_process(delta):
	timer+=delta
	if(timer>timeout):
		var children = get_children()
		var selected_spawn_point = get_child(randi()%get_child_count());
		var shape = selected_spawn_point.shape.extents
		print(shape.x)
		var spawn_point = selected_spawn_point.global_position+Vector2(rand_range(-shape.x,shape.x),rand_range(-shape.y,shape.y))
		print(spawn_point)
		var new_enemy = enemy_object.instance()
		new_enemy.position = spawn_point
		$"../Enemies".add_child(new_enemy)
		timer = 0
	
