extends EnemyState

func enter(previous_state_path: String, data := {}) -> void:
	print("DEBUG: Chasing")

func physics_update(_delta: float) -> void:
	enemy.set_movement_target(enemy.get_player_position())
	enemy.handle_movement()
	
	if enemy.is_player_in_attack_range:
		finished.emit(GRAPPLING)
	elif enemy.is_attacked:
		finished.emit(KNOCKEDBACK)
