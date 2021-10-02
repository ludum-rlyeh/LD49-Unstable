extends Camera2D

export (float) var interpolation_time = 1

func on_height_changed(height):
	var viewport_size = get_viewport_rect().size
	var target_zoom = height / viewport_size.y
	var new_size = viewport_size * target_zoom
	var target_offset = Vector2(-new_size.x * 0.5 + viewport_size.x * 0.5, -viewport_size.y * (target_zoom - 1))
	$Tween.interpolate_property(self, "zoom", zoom, Vector2(target_zoom, target_zoom), interpolation_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property(self, "offset", offset, target_offset, interpolation_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	
# tests
#func _process(delta):
#	if Input.is_action_just_pressed("ui_accept"):
#		on_height_changed(get_viewport_rect().size.y * 2)
#
#	if Input.is_action_just_pressed("ui_down"):
#		on_height_changed(get_viewport_rect().size.y)
