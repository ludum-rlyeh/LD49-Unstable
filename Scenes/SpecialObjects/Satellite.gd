extends "res://Scenes/FallingObject.gd"

func _ready():
	$AnimationPlayer.play("lights")
	
func explodes():
	$AnimationPlayer.play("explode")
