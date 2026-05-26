extends EnemyState

func enter(previous_state_path: String, data := {}) -> void:
	print("Grappling")
	grapple()

func grapple():
	print("Player grappled")
	await get_tree().create_timer(5.0).timeout
	enemy.is_player_in_attack_range = false
	print("Player cannot be grappled")
	
	#TODO: Handle grapple on player end
	finished.emit(CHASING)
