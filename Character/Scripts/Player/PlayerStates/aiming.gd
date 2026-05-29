extends PlayerState

var aiming_speed: float

func enter(previous_state_path: String, data := {}) -> void:
	aiming_speed = player.speed / 2
	player.anim_player.play("aim")
	player.model_animator.play("Player/Walking_C")

func physics_update(_delta: float) -> void:
	player.handle_rotation()
	player.handle_movement(aiming_speed)
	
	if player.is_aiming:
		if player.is_grappled:
			finished.emit(GRAPPLED)
		if player.is_attacking:
			finished.emit(ATTACKING)
	else:
		if player.input_dir.x != 0 or player.input_dir.y != 0:
			finished.emit(MOVING)
		else:
			finished.emit(IDLE)
