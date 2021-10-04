extends "res://Scenes/FallingObject.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var score = 0
var glitchScore = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	self.position.x = 1
	self.position.y = -50
	
func _process(delta):
	$Label.text = String(score)

func uPPosition():
	self.position.y -= 800
	self.position.x -= 300
	set_scale(Vector2(2,2))

func DownPosition():
	self.position.y += 800
	self.position.x += 300
	
	
func changeSize(factor):
	pass
