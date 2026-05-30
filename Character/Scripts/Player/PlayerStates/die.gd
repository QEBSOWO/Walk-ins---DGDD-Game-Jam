extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.model_animator.play("Player/Death_B")
	player.model_animator.animation_finished.connect(_on_anim_end)

func _on_anim_end(anim_name: String) -> void:
	player.died.emit()
