extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.velocity.x = 0.0
	player.velocity.z = 0.0

func physics_update(_delta: float) -> void:
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	# Handle State change
	if input_dir.x != 0 or input_dir.y != 0:
		finished.emit(MOVING)
