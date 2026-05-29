extends EnemyState

func enter(previous_state_path: String, data := {}) -> void:
	enemy.initialize()
	
	if enemy.is_player_detected && enemy.player.can_be_grappled:
		finished.emit(CHASING)
	else:
		finished.emit(PATROLLING)
