extends EnemyState

var enemy_recovered = false

func enter(previous_state_path: String, data := {}) -> void:
	enemy.velocity.x = 0
	enemy.velocity.z = 0
	enemy.can_be_damaged = true
	enemy.can_grapple = true
	print("Enemy Staggered")
	
	await get_tree().create_timer(enemy.stagger_duration).timeout
	enemy_recovered = true

func physics_update(_delta: float) -> void:
	if enemy_recovered:
		if enemy.current_hp <= 0:
			finished.emit(DIE)
		else:
			finished.emit(CHASING)

func exit() -> void:
	enemy_recovered = false
	enemy.is_attacked = false
