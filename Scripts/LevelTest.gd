extends Node2D

var _current_height = 0

func _ready():
	_current_height = get_viewport_rect().size.y

func _input(event):
	if event.is_action_pressed("ui_accept"):
		var falling_object = $Popper.pop_object_with_initial_position()
		if falling_object != null :
			call_deferred("_add_falling_object", falling_object[0], falling_object[1])
			
#	if event.is_action_pressed("ui_page_up"):
#		var new_pos = $Popper.position
#		new_pos.y -= _current_height
#		_current_height *= 2.0
#		Signals.emit_signal("popper_height_changed", _current_height)
#		$Popper.update_height(new_pos)
#	elif event.is_action_pressed("ui_page_down"):
#		if _current_height > get_viewport_rect().size.y :
#			_current_height /= 2.0
#			var new_pos = $Popper.position
#			new_pos.y += _current_height
#			Signals.emit_signal("popper_height_changed", _current_height)
#			$Popper.update_height(new_pos)
			
func _add_falling_object(falling_object : RigidBody2D, init_global_position : Vector2):
	add_child(falling_object)
	falling_object.set_global_position(init_global_position)
	falling_object.set_mode(RigidBody2D.MODE_RIGID)

func _process(delta):
	
	var new_pos = $Popper.position
	if $Scorer.position.y < _current_height / 4.0:
		new_pos.y -= _current_height
		_current_height *= 2.0
	elif _current_height > get_viewport_rect().size.y and $Scorer.position.y > 3.0 * _current_height / 4.0 :
		_current_height /= 2.0
		new_pos.y += _current_height

	if new_pos != $Popper.position:
		Signals.emit_signal("popper_height_changed", _current_height)
		$Popper.update_height(new_pos)
