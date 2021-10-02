extends KinematicBody2D
var x = 0
var _speed_scale = 0
export (Vector2) var speed = Vector2(1, 0)

func _init():
	set_process(true)

func _physics_process(delta):
	if Input.is_action_pressed("ui_shift"):
		_speed_scale = 0.5
	elif !Input.is_action_pressed("ui_shift"):
		_speed_scale = 1
	if Input.is_action_pressed("ui_right"):
		x += _speed_scale * 2
	elif Input.is_action_pressed("ui_left"):
		x -= _speed_scale * 2
	elif (x < 0):
			x += 1
	elif (x > 0):
			x -= 1
	move_and_collide(0.05 * x * speed * delta)
