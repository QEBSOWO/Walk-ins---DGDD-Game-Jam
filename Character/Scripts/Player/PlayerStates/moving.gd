extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.anim_player.play("RESET")
	pass

func physics_update(_delta: float) -> void:
	player.handle_rotation()
	player.handle_movement()
	
	# Handle State change
	if is_equal_approx(player.input_dir.x, 0.0) and is_equal_approx(player.input_dir.y, 0.0):
		finished.emit(IDLE)
	elif player.is_grappled:
		finished.emit(GRAPPLED)
	elif player.is_aiming:
		finished.emit(AIMING)
