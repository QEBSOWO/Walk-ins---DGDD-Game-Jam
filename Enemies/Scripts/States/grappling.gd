extends EnemyState

func enter(previous_state_path: String, data := {}) -> void:
	print("Grappling")
	enemy.velocity.x = 0
	enemy.velocity.z = 0
	enemy.grapple_player()

func physics_update(_delta: float) -> void:
	enemy.move_and_slide()
