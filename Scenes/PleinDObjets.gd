extends RigidBody2D

export (float) var gravityStrength = 10000

var tabObjets:Array = []
var mouseOver = false
# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.connect("ad_fall", self,"on_ad_fall") # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	for object in tabObjets:
		if object != self: #and object.mass <= self.mass:
			var dist : float = (object.get_position() - self.get_position()).length()
			var attractStrength : float = gravityStrength / (dist*dist)
			var attractDirection : Vector2 = (self.get_position() - object.get_position()).normalized()
			object.apply_central_impulse(attractDirection * attractStrength)
			
		
func _input(event):
	if mouseOver == true:
		if event is InputEventMouseButton:
			if event.pressed:
				if event.button_index == BUTTON_LEFT:
					$Sprite/AnimationPlayer.play("Default")
					Signals.emit_signal("ad_click")



func _on_Area2D_body_entered(body):
	if body is RigidBody2D and tabObjets.size() <20:
		tabObjets.append(body)
	


func _on_Area2D_body_exited(body):
	if body is RigidBody2D:
		var i = tabObjets.find(body)
		if i != -1:
			tabObjets.remove(i)
				


func _on_Area2D_mouse_entered():
	mouseOver = true


func _on_Area2D_mouse_exited():
	mouseOver = false 
	$Sprite/AnimationPlayer.stop()

func on_ad_fall():
	print("adfall")
	self.call_deferred("set_mode", RigidBody2D.MODE_RIGID) 
	$CollisionPolygon2D.disabled = false
