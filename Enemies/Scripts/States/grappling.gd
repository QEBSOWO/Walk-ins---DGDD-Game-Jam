extends EnemyState

func enter(previous_state_path: String, data := {}) -> void:
	enemy.grapple_qte.successful_input.connect(_on_successful_qte)
	enemy.grapple_qte.failed_input.connect(_on_failed_qte)
	
	print("Grappling")
	enemy.velocity.x = 0
	enemy.velocity.z = 0
	enemy.grapple_player()
	#await get_tree().create_timer(enemy.grapple_cooldown).timeout
	#finished.emit(KNOCKEDBACK)

func _on_successful_qte():
	enemy.release_grappled_player()
	finished.emit(KNOCKEDBACK)


func _on_failed_qte():
	enemy.release_grappled_player()
	finished.emit(KNOCKEDBACK)
