extends "res://Scenes/FallingObject.gd"

var initial_y = 0
var speed = 20
var max_score = 100

func _ready():
	initial_y = self.position.y
	Signals.connect("score_changed", self, "on_score_changed")

func on_score_changed(score):
	self.call_deferred("update_status", score)

func update_status(score):
	$Label.text = String(int(round(score * 10.0)))
	
	if self.mode != RigidBody2D.MODE_RIGID:
		if int(round(score * 10.0)) < max_score:
			if self.position.y <= initial_y :
				self.position.y = initial_y - speed * score
			else:
				self.position.y = initial_y
		else:
			self.mode = RigidBody2D.MODE_RIGID
			$CollisionPolygon2D.disabled = false
			$GravityZone/CollisionPolygon2D.disabled = false
