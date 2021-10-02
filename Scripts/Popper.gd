extends Position2D

export var speed = Vector2(100.0,0.0)

export var seconds_between_pops = 10

var _falling_objects_path = "res://Scenes/FallingObjects/"
var _falling_objects_ressources = []
var _current_id = 0

var _can_drop = false
var _next_object = null

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
	randomize()

func _process(delta):
	self.position += speed * delta
	if self.position.x < get_viewport_rect().size.x / 4.0 or self.position.x > 3.0 * get_viewport_rect().size.x / 4.0 :
		speed.x *= -1.0

func pop_object():
	if _can_drop :
		_can_drop = false
		self.remove_child(_next_object)
		$Timer.start(seconds_between_pops)
		_next_object.set_position(self.position)
		return _next_object
	return null

func on_timer_timeout():
	_current_id = randi() % _falling_objects_ressources.size()
	_next_object = _falling_objects_ressources[_current_id].instance()
	_next_object.set_mode(RigidBody2D.MODE_STATIC)
	call_deferred("add_child", _next_object)
	_can_drop = true
	
