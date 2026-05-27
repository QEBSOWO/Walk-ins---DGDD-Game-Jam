extends EnemyState

func enter(previous_state_path: String, data := {}) -> void:
	#TODO: Play animation for enemy dying
	enemy.queue_free()
