extends Node2D

func _input(event):
	if event.is_action_pressed("ui_accept"):
		var falling_object = $Popper.pop_object()
		if falling_object != null :
			call_deferred("add_child", falling_object)
			falling_object.set_mode(RigidBody2D.MODE_RIGID)

