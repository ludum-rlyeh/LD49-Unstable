extends Node2D

export (bool) var debug = false

func _ready():
	Signals.connect("step_changed", self, "on_step_changed")
	randomize()
	
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
	
func on_step_changed(step):
	if step == 2:
		$Orbit/PathFollow/Satellite/SatelliteAnimationPlayer.play("orbit")
		$Orbit/PathFollow/Satellite/Fall.wait_time = 13
		$Orbit/PathFollow/Satellite/Fall.start()
		$Meteor/AnimationPlayer.play("falling")

func _on_Fall_timeout():
	satellite_explodes()
