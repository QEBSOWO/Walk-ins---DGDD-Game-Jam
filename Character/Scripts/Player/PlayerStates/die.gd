extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.model_animator.play("Player/Death_B")
	#TODO: Add Game end things
