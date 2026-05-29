extends EnemyState

func enter(previous_state_path: String, data := {}) -> void:
	#TODO: Play animation for enemy dying
	print(enemy.current_hp)
	enemy.queue_free()
