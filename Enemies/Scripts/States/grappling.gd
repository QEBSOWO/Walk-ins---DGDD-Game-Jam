extends EnemyState

func enter(previous_state_path: String, data := {}) -> void:
	print("Grappling")
	enemy.grapple_player()
