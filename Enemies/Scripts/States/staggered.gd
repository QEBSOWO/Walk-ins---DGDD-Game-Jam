extends EnemyState

func enter(previous_state_path: String, data := {}) -> void:
	enemy.velocity.x = 0
	enemy.velocity.z = 0
	enemy.can_be_damaged = true
	print("Enemy Staggered")

func physics_update(_delta: float) -> void:
	await get_tree().create_timer(enemy.stagger_duration).timeout
	
	if enemy.current_hp <= 0:
		finished.emit(DIE)
	else:
		finished.emit(CHASING)
