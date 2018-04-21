extends StaticBody2D

var POWER_MODIFIER = 2000;

func _ready():
	add_to_group("pickup");
	pass

func do_collide():
	queue_free()
	pass