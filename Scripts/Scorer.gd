extends Node2D

var score = 0
var initial_y = 0
var speed = 100

func _ready():
	Signals.connect("height_updated", self, "on_height_updated")
	var viewport_size_x = get_viewport_rect().size.x
	$RayCast2D.cast_to.x = -viewport_size_x
	initial_y = self.position.y
	
func on_height_updated():
	self.position.x += get_viewport_rect().size.x / 2.0
	$RayCast2D.cast_to.x -= get_viewport_rect().size.x

func _process(delta):
	if $RayCast2D.is_colliding() :
		score += delta
	elif score > 0:
		score -= delta

	if self.position.y <= initial_y :
		self.position.y = initial_y - speed * score
	else:
		self.position.y = initial_y
	
	#print("SCORE: " + String(int(round(score * 10.0))))
	
	Signals.emit_signal("score_changed", score)
	
	
