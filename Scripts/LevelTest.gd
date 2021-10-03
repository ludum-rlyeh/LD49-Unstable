extends Node2D

var _current_height = 0
var update_height = false

func _ready():
	_current_height = get_viewport_rect().size.y
	Signals.connect("height_updated", self, "on_height_updated")
	$Timer.connect("timeout", self, "on_timer_timeout")

func on_timer_timeout():
	var falling_object = $Popper.pop_object_with_initial_position()
	if falling_object != null :
		call_deferred("_add_falling_object", falling_object[0], falling_object[1])

func _add_falling_object(falling_object : RigidBody2D, init_global_position : Vector2):
	add_child(falling_object)
	falling_object.set_global_position(init_global_position)
	falling_object.set_mode(RigidBody2D.MODE_RIGID)

func _process(delta):
	
	if not update_height :
		var new_pos = $Popper.position
		if abs($Scorer.position.y - $Popper.position.y) < _current_height / 3.0:
			new_pos.y -= get_viewport_rect().size.y
			_current_height += get_viewport_rect().size.y
			update_height = true
			Signals.emit_signal("popper_height_changed", _current_height)
			$Popper.update_height(new_pos)

func on_height_updated():
	update_height = false
