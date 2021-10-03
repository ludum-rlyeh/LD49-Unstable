extends Position2D

export var speed = Vector2(100.0,0.0)
export var seconds_between_pops = 1
export (float, 0, 1) var range_viewport_ratio_patrol = 0.66

var _falling_objects_path = "res://Scenes/FallingObjects/"
var _falling_objects_ressources = []
var _current_id = 0

var _can_drop = false
var _next_object : RigidBody2D = null

var _new_pos = null


onready var _drone = $StaticBody2D
onready var _pin = $StaticBody2D/PinJoint2D
onready var _min_x = 0
onready var _max_x = 0

func _init():
	var dir = Directory.new()
	dir.open(_falling_objects_path)
	
	dir.list_dir_begin()
	while true:
		var file_name = dir.get_next()
		if file_name == "":
			#break the while loop when get_next() returns ""
			break
		elif !file_name.begins_with("."):
			#get_next() returns a string so this can be used to load the images into an array.
			_falling_objects_ressources.append(load(_falling_objects_path + file_name))
	dir.list_dir_end()

func _ready():
	$Timer.connect("timeout", self, "on_timer_timeout")
	var viewport_size_x = get_viewport_rect().size.x 
	_min_x = viewport_size_x * (1 - range_viewport_ratio_patrol) * 0.5
	_max_x = viewport_size_x - _min_x
	$StaticBody2D/AnimatedSprite.rotation_degrees = 25
	randomize()

func _process(delta):
	if _new_pos != null :
		if self.position.distance_to(_new_pos) > 10.0 :
			self.position = self.position.linear_interpolate(_new_pos, delta)
		else:
			Signals.emit_signal("height_updated")
			_new_pos = null
	else:
		_drone.position += speed * delta
		if _drone.global_position.x < _min_x or _drone.global_position.x > _max_x :
			speed.x *= -1.0
			$Tween.interpolate_property($StaticBody2D/AnimatedSprite, "rotation_degrees", $StaticBody2D/AnimatedSprite.rotation_degrees, 25 * sign(speed.x), 0.25)
			$Tween.start()

func pop_object_with_initial_position():
	if _can_drop :
		_can_drop = false
		_pin.set_node_b("")
		$Timer.start(seconds_between_pops)
		$AudioStreamPlayer2D.play()
		
		var init_global_position = _next_object.global_position
		call_deferred("remove_child", _next_object)
		return [_next_object, init_global_position]
	return null

func on_timer_timeout():
	_current_id = randi() % _falling_objects_ressources.size()
	_next_object = _falling_objects_ressources[_current_id].instance()
	_next_object.set_mode(RigidBody2D.MODE_RIGID)
	_next_object.set_position(_drone.position + Vector2.DOWN * 50.0)
	add_child(_next_object)
	_pin.set_node_b(_next_object.get_path())
	_can_drop = true

func update_height(pos):
	_new_pos = pos
	
