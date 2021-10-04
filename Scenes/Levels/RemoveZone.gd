extends Area2D



func _on_RemoveZone_body_entered(body : Node):
	if body.name == "Score":
		return
	var parent = body.get_parent()
	parent.call_deferred("remove_node", body)
	body.call_deferred("queue_free")
