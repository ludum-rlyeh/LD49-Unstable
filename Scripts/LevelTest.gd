extends Node2D

var _falling_object_resource = preload("res://Scenes/FallingObject.tscn")
onready var _zone = $Zone

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
