extends PlayerState

var timer: SceneTreeTimer

func enter(previous_state_path: String, data := {}) -> void:
	print("Player Grappled")
	player.is_aiming = false
	player.can_move = false
	player.can_be_grappled = false
	player.anim_player.play("RESET")
	player.model_animator.play("Player/Hit_A")
	player.velocity.x = 0.0
	player.velocity.z = 0.0
	player.take_damage(1)
	

func physics_update(_delta: float) -> void:
	if !player.is_grappled:
		if player.current_hp <= 0:
			finished.emit(DIE)
		else:
			finished.emit(IDLE)


func exit() -> void:
	player.can_attack = true
	player.can_move = true
	
	if !(player.current_hp <= 0): # If player is still alive
		player.can_be_grappled = true
