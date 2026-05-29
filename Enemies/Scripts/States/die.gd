extends EnemyState

func enter(previous_state_path: String, data := {}) -> void:
	print(enemy.current_hp)
	enemy.anim_player.play("Death")
	await enemy.anim_player.animation_finished
	enemy.queue_free()
