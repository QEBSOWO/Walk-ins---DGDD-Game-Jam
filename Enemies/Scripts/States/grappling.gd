extends EnemyState

func enter(previous_state_path: String, data := {}) -> void:
	print("Grappling")
	enemy.velocity.x = 0
	enemy.velocity.z = 0
	enemy.grapple_player()
	await get_tree().create_timer(enemy.grapple_cooldown).timeout
	finished.emit(KNOCKEDBACK)
