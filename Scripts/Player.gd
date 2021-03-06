extends KinematicBody2D
var x = 0
onready var last_pos : Vector2 = position
export (Vector2) var speed = Vector2(1, 0)

var _wheels : Array = []
onready var _head_pos_init = $Head.position
var normalControls = 1
var objectsInZone = -3
var speedScale = 1

var _game_ended

func _init():
	set_process(true)
	
func _ready():
	for child in $Wheels.get_children():
		_wheels.append(child)
		
	var error = Signals.connect("popper_height_changed", self, "_on_height_changed")
	Signals.connect("game_started", self, "_on_game_started")
	Signals.connect("game_ended", self, "on_game_ended")
	
func on_game_ended():
	_game_ended = true
		
func _on_height_changed(height):
	$Arms/ArmRight.unfold(height)
	$Arms/ArmLeft.unfold(height)
		
func _process(delta):
	if abs(last_pos.x  - position.x) > 0.1:
		for wheel in _wheels:
			wheel.rotate(3.14/10)
		$ChainAnimated.play("roll")
	else:
		$ChainAnimated.play("idle")
		
	last_pos = position

func _physics_process(delta):
	if _game_ended:
		move_and_collide(Vector2(0, 9.81 * 100 * delta))
		return
	
	var v = speed
	if normalControls != 1:
		v = -speed

	if Input.is_action_pressed("ui_right"):
		move_and_collide(v * delta * speedScale)
		if not $AudioStreamPlayer2D.playing:
			$AudioStreamPlayer2D.play()
	elif Input.is_action_pressed("ui_left"):
		move_and_collide(-v * delta * speedScale)
		if not $AudioStreamPlayer2D.playing:
			$AudioStreamPlayer2D.play()
	elif Input.is_action_just_released("ui_right") or Input.is_action_just_released("ui_left"):
		if $AudioStreamPlayer2D.playing:
			$AudioStreamPlayer2D.stop()

func _on_HeadDownTimer_timeout():
	$AnimationPlayer.play("head_down")
	$HeadDownTimer.start()


func _on_Area2D_body_entered(body):
	if(body is RigidBody2D):
		objectsInZone += 1
	


func _on_Area2D_body_exited(body):
	objectsInZone -= 1

func _on_game_started():
	$LeftKey.visible = false
	$RightKey.visible = false


