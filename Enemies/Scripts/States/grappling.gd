extends EnemyState

func enter(previous_state_path: String, data := {}) -> void:
	enemy.stagger.connect(_on_enemy_stagger)
	
	print("Grappling")
	enemy.velocity.x = 0
	enemy.velocity.z = 0
	enemy.grapple_player()

func physics_update(_delta: float) -> void:
	enemy.move_and_slide()

func _on_enemy_stagger() -> void:
	await get_tree().create_timer(enemy.knockback_duration).timeout
	finished.emit(STAGGERED)
