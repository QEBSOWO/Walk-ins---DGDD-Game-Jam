extends EnemyState

func enter(previous_state_path: String, data := {}) -> void:
	print("Enemy knocked back")
	enemy.release_grappled_player()
	
	await get_tree().create_timer(enemy.knockback_duration).timeout
	finished.emit(STAGGERED)

func physics_update(_delta: float) -> void:
	enemy.move_and_slide()
