extends EnemyState

var can_chase_player: bool = false

# Test for movement and collision
func enter(previous_state_path: String, data := {}) -> void:
	enemy.set_movement_target(enemy.select_random_waypoint())
	
	if !previous_state_path == SPAWNING:
		await get_tree().create_timer(3).timeout
	
	can_chase_player = true
	print("Start chasing")

func physics_update(_delta: float) -> void:
	enemy.handle_movement()
	
	if enemy.is_player_detected && enemy.player.can_be_grappled && can_chase_player:
		finished.emit(CHASING)
	elif enemy.is_attacked:
		finished.emit(KNOCKEDBACK)
