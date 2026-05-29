extends EnemyState

func enter(previous_state_path: String, data := {}) -> void:
	enemy.initialize()
	
	if enemy.is_player_detected:
		finished.emit(CHASING)
	else:
		finished.emit(PATROLLING)

func _on_player_detected() -> void:
	finished.emit(CHASING)
