extends EnemyState

func enter(previous_state_path: String, data := {}) -> void:
	print("DEBUG: Chasing")

func physics_update(_delta: float) -> void:
	enemy.set_movement_target(enemy.get_player_position())
	enemy.handle_movement()
	
	if enemy.is_attacked:
		finished.emit(KNOCKEDBACK)
	elif enemy.is_player_in_attack_range && enemy.player.can_be_grappled:
		await get_tree().create_timer(0.15).timeout # Buffer so it's not instant
		if enemy.is_player_in_attack_range && !enemy.is_attacked && enemy.can_grapple:
			finished.emit(GRAPPLING)
	elif !enemy.player.can_be_grappled:
		finished.emit(PATROLLING)
