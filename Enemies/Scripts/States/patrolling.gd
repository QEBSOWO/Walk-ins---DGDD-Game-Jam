extends EnemyState

# Test for movement and collision

func physics_update(_delta: float) -> void:
	enemy.handle_movement()
	
	if enemy.is_player_detected:
		finished.emit(CHASING)
	elif enemy.is_attacked:
		finished.emit(KNOCKEDBACK)
