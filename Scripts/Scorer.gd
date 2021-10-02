extends Node2D

var score = 0
var initial_y = 0
var speed = 20

func _ready():
	$RayCast2D.cast_to.x = -get_viewport_rect().size.x
	initial_y = self.position.y

func _process(delta):
	if $RayCast2D.is_colliding() :
		score += delta
	elif score > 0:
		score -= delta
	$Label.text = String(int(round(score))) + " m"

	if self.position.y <= initial_y :
		self.position.y = initial_y - speed * score
	else:
		self.position.y = initial_y
