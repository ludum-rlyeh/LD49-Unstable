extends Node2D

var score = 0
var initial_y = 0
var speed = 20

func _ready():
	var viewport_size_x = get_viewport_rect().size.x
	$RayCast2D.cast_to.x = -viewport_size_x
	initial_y = self.position.y
	

func _process(delta):
	if $RayCast2D.is_colliding() :
		score += delta
	elif score > 0:
		score -= delta

	if self.position.y <= initial_y :
		self.position.y = initial_y - speed * score
	else:
		self.position.y = initial_y
	
	Signals.emit_signal("score_changed", score)
	
	
