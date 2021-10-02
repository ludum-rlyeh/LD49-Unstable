extends Node2D


var _falling_object_resource = preload("res://Scenes/FallingObjects/Chaise.tscn")
onready var _zone = $Zone

var _falling_objects_path = "res://Scenes/FallingObjects/"
var _falling_objects_ressources = []

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
			_falling_objects_ressources.append(_falling_objects_path + file_name)
	dir.list_dir_end()
	print (_falling_objects_ressources)


func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		pop_falling_object_in_zone(_zone.get_node("Min").global_position, _zone.get_node("Max").global_position)

func instance_falling_object(position : Vector2) -> RigidBody2D :
	var object = _falling_object_resource.instance()
	object.position = position
	return object
	
func pop_falling_object_in_zone(position_min : Vector2, position_max : Vector2) -> void:
	var pos = Vector2(rand_range(position_min.x, position_max.x), rand_range(position_min.y, position_max.y))
	var object = instance_falling_object(pos)
	call_deferred("add_child", object)
