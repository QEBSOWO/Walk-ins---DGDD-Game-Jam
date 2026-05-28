extends PlayerState

var aiming_speed: float

func enter(previous_state_path: String, data := {}) -> void:
	aiming_speed = player.speed / 2

func physics_update(_delta: float) -> void:
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		player.velocity.x = direction.x * aiming_speed
		player.velocity.z = direction.z * aiming_speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, aiming_speed)
		player.velocity.z = move_toward(player.velocity.z, 0, aiming_speed)

	player.move_and_slide()
