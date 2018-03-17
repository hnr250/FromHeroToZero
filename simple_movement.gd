extends KinematicBody2D

var VELOCITY = 4

func _physics_process(delta):

    if Input.is_action_pressed("ui_left"):
        move_and_collide(Vector2(-VELOCITY, 0))
    elif Input.is_action_pressed("ui_right"):
        move_and_collide(Vector2(VELOCITY, 0))
		
		
    if Input.is_action_pressed("ui_up"):
       move_and_collide(Vector2(0, -VELOCITY))
    elif Input.is_action_pressed("ui_down"):
       move_and_collide(Vector2(0, VELOCITY))
