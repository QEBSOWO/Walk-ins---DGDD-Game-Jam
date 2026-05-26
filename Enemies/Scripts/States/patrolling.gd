extends EnemyState

# Test for movement and collision
func enter(previous_state_path: String, data := {}) -> void:
	enemy.player_detected.connect(_on_player_detected)

func physics_update(_delta: float) -> void:
	enemy.handle_movement()

func _on_player_detected() -> void:
	finished.emit(CHASING)
