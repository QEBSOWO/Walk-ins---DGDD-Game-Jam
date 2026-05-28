extends EnemyState

var knockback_complete = false

func enter(previous_state_path: String, data := {}) -> void:
	_set_knockback_velocity()
	print("Enemy knocked back")
	await get_tree().create_timer(enemy.knockback_duration).timeout
	knockback_complete = true

func physics_update(_delta: float) -> void:
	enemy.move_and_slide()
	
	if knockback_complete:
		finished.emit(STAGGERED)

func _set_knockback_velocity():
	enemy.velocity = (enemy.position-Vector3(enemy.player.position.x, 0, enemy.player.position.z)).normalized() * enemy.grapple_escape_force
