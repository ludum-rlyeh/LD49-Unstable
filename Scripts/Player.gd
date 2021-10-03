extends KinematicBody2D
var x = 0
var _speed_scale = 0
onready var last_pos : Vector2 = position
export (Vector2) var speed = Vector2(1, 0)

var _wheels : Array = []
onready var _head_pos_init = $Head.position

func _init():
	set_process(true)
	
func _ready():
	for child in $Wheels.get_children():
		_wheels.append(child)
		
func _process(delta):
	if abs(last_pos.x  - position.x) > 0.1:
		for wheel in _wheels:
			wheel.rotate(3.14/10)
		$ChainAnimated.play("roll")
	else:
		$ChainAnimated.play("idle")
		
			
	last_pos = position
	

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



func _on_HeadDownTimer_timeout():
	$AnimationPlayer.play("head_down")
	$HeadDownTimer.start()
