extends "res://Scenes/FallingObject.gd"

var new_pos = null

func _ready():
	Signals.connect("score_changed", self, "_on_score_changed")

func _on_Button_pressed():
	Signals.emit_signal("game_started")
	call_deferred("move_to_sky")
	
func _on_score_changed(score):
	if self.mode != RigidBody2D.MODE_RIGID and int(round(score * 10.0)) > 130 :
		call_deferred("fall")

func move_to_sky():
	$Button.disabled = true
	new_pos = Vector2(self.position.x, self.position.y - 4.0 * get_viewport_rect().size.y)

func fall():
	$CollisionPolygon2D.disabled = false
	$GravityZone/CollisionShape2D.disabled = false
	self.mode = RigidBody2D.MODE_RIGID
	$AudioStreamPlayer2D.play()

func _process(delta):
	if new_pos != null :
		if self.position.distance_to(new_pos) > 10.0 :
			self.position = self.position.linear_interpolate(new_pos, delta)
		else:
			new_pos = null
			self.set_process(false)
