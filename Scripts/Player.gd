extends KinematicBody2D

export (Vector2) var speed = Vector2(20, 0)

func _init():
	set_process(true)

func _process(delta):
	if Input.is_action_pressed("ui_right"):
		position += speed * delta
	elif Input.is_action_pressed("ui_left"):
		position -= speed * delta
