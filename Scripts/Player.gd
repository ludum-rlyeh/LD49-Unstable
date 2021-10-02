extends KinematicBody2D
var x = 0
var y = 0
export (Vector2) var speed = Vector2(1, 0)

func _init():
	set_process(true)

func _process(delta):
	if Input.is_action_pressed("ui_shift"):
		y = 0.5
	elif !Input.is_action_pressed("ui_down"):
		y = 1
	if Input.is_action_pressed("ui_right"):
		x += y * 2
	elif Input.is_action_pressed("ui_left"):
		x -= y * 2
	elif (x < 0):
			x += 1
	elif (x > 0):
			x -= 1
	position += 0.05 * x * speed * delta
