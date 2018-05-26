# Fireball.gd
extends Area2D

const FIREBALL_SPEED = 200
var speed_x = 1
var speed_y = 0

func _ready():
	connect('body_entered', self, 'on_body_entered')
	set_process(true)

func _process(delta):
	var motion = Vector2(speed_x, speed_y) * FIREBALL_SPEED
	global_position = global_position + motion * delta

func _on_VisibilityNotifier2D_exit_screen():
	queue_free()

func _on_Fireball_area_enter( area ):
	queue_free()
	area.queue_free()
	
func on_body_entered( area ):
	if(area.is_in_group("enemy")):
		var player = get_tree().get_root().get_node("Tileset/player")
		player.STATS = area.do_collide(player.STATS)
		queue_free()
	if(not area.is_in_group("player")):
		queue_free()
	