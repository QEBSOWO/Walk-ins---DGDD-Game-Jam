extends PlayerState

var aiming_speed: float

func enter(previous_state_path: String, data := {}) -> void:
	aiming_speed = player.speed / 2

func physics_update(_delta: float) -> void:
	# Calculations for positioning player aiming
	var mouse_pos = get_viewport().get_mouse_position()
	
	player.handle_rotation(Vector3(mouse_pos.x, 0, mouse_pos.y))
	player.handle_movement(aiming_speed)
	
	if !player.is_aiming:
		if player.input_dir.x != 0 or player.input_dir.y != 0:
			finished.emit(MOVING)
		else:
			finished.emit(IDLE)
