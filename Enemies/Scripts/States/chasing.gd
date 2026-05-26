extends EnemyState

func enter(previous_state_path: String, data := {}) -> void:
	print("DEBUG: Chasing")

func physics_update(_delta: float) -> void:
	enemy.set_movement_target(enemy.get_player_position())
	enemy.handle_movement()
