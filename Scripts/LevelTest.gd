extends Node2D

var _current_height = 0
var update_height = false
var bgIndex = 1

var _height_step = 0

export (bool) var debug = false

onready var animation_player = $BG/BgGlitchAnimation

func _ready():
	_current_height = get_viewport_rect().size.y
	Signals.connect("height_updated", self, "on_height_updated")
	$Timer.connect("timeout", self, "on_timer_timeout")

func on_timer_timeout():
	var falling_object = $Popper.pop_object_with_initial_position()
	if falling_object != null :
		call_deferred("_add_falling_object", falling_object[0], falling_object[1])
	#BackgroundGlitch
	glichBgRng()

func _add_falling_object(falling_object : RigidBody2D, init_global_position : Vector2):
	add_child(falling_object)
	falling_object.set_global_position(init_global_position)
	falling_object.set_mode(RigidBody2D.MODE_RIGID)

func _process(delta):
	
	if not update_height :
		if abs($Scorer.position.y - $Popper.position.y) < _current_height / 3.0:
			_update_step()
			
		if debug:
			if Input.is_action_just_pressed("ui_up"):
				_update_step()
				
func _update_step():
	var new_pos = $Popper.position
	new_pos.y -= get_viewport_rect().size.y
	_current_height += get_viewport_rect().size.y
	update_height = true
	_height_step += 1
	Signals.emit_signal("popper_height_changed", _current_height)
	Signals.emit_signal("step_changed", _height_step)
	$Popper.update_height(new_pos)

func on_height_updated():
	update_height = false
	
func glichBgRng():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var randNumber = rng.randf_range(0, 1)
	if randNumber > 0.80:
			glitchBg(1)
			get_viewport().render_target_v_flip = false
			$Player2.normalControls = 1
	else:
		if randNumber < 0.05:
			get_viewport().render_target_v_flip = true
			$Player2.normalControls = 0
			glitchBg(2)	 
		
func glitchBg(i):
	if i == 1:		
		animation_player.play("BgNonGlitch")
	else:		
		animation_player.play("BgGlitch")
		
