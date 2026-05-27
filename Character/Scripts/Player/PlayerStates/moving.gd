extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	# TODO: Play animation here
	pass

func physics_update(_delta: float) -> void:
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		player.velocity.x = direction.x * player.speed
		player.velocity.z = direction.z * player.speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.speed)
		player.velocity.z = move_toward(player.velocity.z, 0, player.speed)

	player.move_and_slide()
	
	# Handle State change
	if is_equal_approx(input_dir.x, 0.0) and is_equal_approx(input_dir.y, 0.0):
		finished.emit(IDLE)
	elif player.is_grappled:
		finished.emit(GRAPPLED)
