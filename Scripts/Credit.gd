extends "res://Scenes/FallingObject.gd"

export (int) var score_end = 160

func _ready():
	Signals.connect("score_changed", self, "_on_score_changed")

func _on_score_changed(score):
	if self.mode != RigidBody2D.MODE_RIGID and int(round(score * 10.0)) > score_end :
		call_deferred("fall")

func fall():
	$CollisionPolygon2D.disabled = false
	$GravityZone/CollisionShape2D.disabled = false
	self.mode = RigidBody2D.MODE_RIGID
	$AudioStreamPlayer2D.play()
