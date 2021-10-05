extends Node2D

export (bool) var debug = false

var meteor_resource = preload("res://Scenes/SpecialObjects/MeteorPhysics.tscn")

func _ready():
	Signals.connect("step_changed", self, "on_step_changed")
	Signals.connect("game_ended", self, "on_game_ended")
	randomize()
	
func on_game_ended():
	$Meteors/Timer.stop()
	$Meteors/Timer.disconnect("timeout", self, "_on_Timer_timeout")
	
func _process(delta):
	if debug:
		if Input.is_action_just_pressed("ui_down"):
			satellite_explodes()

func satellite_explodes():
	var satellite : RigidBody2D = $Orbit/PathFollow/Satellite
	var satellite_position = satellite.global_position
	satellite.get_parent().remove_child(satellite)
	add_child(satellite)
	satellite.mode = RigidBody2D.MODE_RIGID
	satellite.global_position = satellite_position
	satellite.explodes()
	
	$Meteors/Timer.start()
	
func on_step_changed(step):
	if step == 2:
		$Orbit/PathFollow/Satellite/SatelliteAnimationPlayer.play("orbit")
		$Orbit/PathFollow/Satellite/Fall.wait_time = 13
		$Orbit/PathFollow/Satellite/Fall.start()
		$Meteor/AnimationPlayer.play("falling")
		

func _on_Fall_timeout():
	satellite_explodes()

func _on_Timer_timeout():
	var meteor : RigidBody2D = meteor_resource.instance()
	$Meteors.add_child(meteor)
	meteor.position = $Meteors/Position2D.position
	var random_n = randf()
	var range_x = $Meteors/Position2D2.position.x - $Meteors/Position2D.position.x
	meteor.position = $Meteors/Position2D.position
	meteor.position.x += random_n * range_x
	$Meteors/Timer.start()
