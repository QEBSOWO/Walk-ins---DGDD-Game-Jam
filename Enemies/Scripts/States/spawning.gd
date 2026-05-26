extends EnemyState

func enter(previous_state_path: String, data := {}) -> void:
	_connect_signals()
	
	enemy.initialize()

func physics_update(_delta: float) -> void:
	if enemy.is_player_detected:
		finished.emit(CHASING)
	else:
		finished.emit(PATROLLING)
