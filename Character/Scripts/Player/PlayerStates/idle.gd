extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.velocity.x = 0.0
	player.velocity.z = 0.0

func physics_update(_delta: float) -> void:
	# Handle State change
	if player.input_dir.x != 0 or player.input_dir.y != 0:
		finished.emit(MOVING)
	elif player.is_grappled:
		finished.emit(GRAPPLED)
	elif player.is_aiming:
		finished.emit(AIMING)
