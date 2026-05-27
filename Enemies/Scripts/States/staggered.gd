extends EnemyState

func enter(previous_state_path: String, data := {}) -> void:
	print("Enemy Staggered")

func physics_update(_delta: float) -> void:
	await get_tree().create_timer(enemy.stagger_duration).timeout
	enemy.can_grapple = true
	
	if enemy.current_hp <= 0:
		finished.emit(DIE)
	else:
		finished.emit(CHASING)
