extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.is_aiming = false
	player.can_attack = false
	player.anim_player.play("RESET")
	player.model_animator.play("Player/Hit_A")
	player.velocity.x = 0.0
	player.velocity.z = 0.0
	player.take_damage(1)

func physics_update(_delta: float) -> void:
	if !player.is_grappled:
		finished.emit(IDLE)
