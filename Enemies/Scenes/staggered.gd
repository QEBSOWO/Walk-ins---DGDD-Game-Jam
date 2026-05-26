extends EnemyState

func enter(previous_state_path: String, data := {}) -> void:
	print("Enemy Staggered")
	enemy.velocity = Vector3.ZERO

func physics_update(_delta: float) -> void:
	await get_tree().create_timer(enemy.stagger_duration).timeout
	finished.emit(CHASING)
