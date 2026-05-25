extends EnemyState

# Test for movement and collision
var movement_target_position: Vector3 = Vector3(0.0, 0.0, 9.5)

func enter(previous_state_path: String, data := {}) -> void:
	# To be adjusted later for actor speed and navigation layout
	nav_agent.path_desired_distance = 0.5
	nav_agent.target_desired_distance = 0.5
	
	#Do not await
	_actor_setup.call_deferred()

func _actor_setup():
	# Wait for first physics frame so NavigationServer can sync
	await get_tree().physics_frame
	
	#Now navigation map is no longer empty, set movement target
	set_movement_target(movement_target_position)

func set_movement_target(movement_target: Vector3):
	nav_agent.set_target_position(movement_target)

func physics_update(_delta: float) -> void:
	if nav_agent.is_navigation_finished():
		return
	
	var current_agent_position: Vector3 = enemy.global_position
	var next_path_position: Vector3 = nav_agent.get_next_path_position()
	
	enemy.velocity = current_agent_position.direction_to(next_path_position) * enemy.speed
	enemy.move_and_slide()
