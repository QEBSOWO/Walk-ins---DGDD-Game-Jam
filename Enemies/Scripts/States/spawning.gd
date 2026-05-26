extends EnemyState

func enter(previous_state_path: String, data := {}) -> void:
	enemy.player_detected.connect(_on_player_detected)
	enemy.initialize()
	finished.emit(PATROLLING)

func _on_player_detected() -> void:
	finished.emit(CHASING)
