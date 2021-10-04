extends Node2D

onready var _id = $Pieces.get_child_count() - 1

func _ready():
	Signals.connect("game_ended", self, "on_game_ended")

func on_game_ended():
	self.show()
	_piece_falls(_id)
	_id -= 1
	$BreakTimer.start()

func _on_BreakTimer_timeout():
	_piece_falls(_id)
	_id -=1
	if _id >= 0:
		$BreakTimer.start()
	else:
		$Spirale/PathFollow2D/Title/TitleTimer.start()

func _piece_falls(id):
	var piece : RigidBody2D = $Pieces.get_child(_id)
	piece.mode = RigidBody2D.MODE_RIGID
	var signe = randi() % 2 * 2 - 1
	piece.add_force(Vector2(0, rand_range(500, 800)), Vector2(signe * rand_range(1000, 2000), 0))
	piece.set_collision_mask_bit(0, true)
	piece.set_collision_layer_bit(0, true)


func _on_TitleTimer_timeout():
	$AnimationPlayer.play("swallowed")
