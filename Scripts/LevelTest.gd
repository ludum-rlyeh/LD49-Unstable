extends Node2D

func _input(event):
	if event.is_action_pressed("ui_accept"):
		var falling_object = $Popper.pop_object_with_initial_position()
		if falling_object != null :
			call_deferred("_add_falling_object", falling_object[0], falling_object[1])
			
func _add_falling_object(falling_object : RigidBody2D, init_global_position : Vector2):
	add_child(falling_object)
	falling_object.set_global_position(init_global_position)
	falling_object.set_mode(RigidBody2D.MODE_RIGID)
