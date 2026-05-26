extends EnemyState

func enter(previous_state_path: String, data := {}) -> void:
	enemy.current_hp = enemy.max_hp
	_connect_signals()

func update(_delta: float) -> void:
	if player == null:
		player = get_tree().root.get_node("Character") as Player

func physics_update(_delta: float) -> void:
	finished.emit(PATROLLING)

func _connect_signals():
	enemy.get_node("PlayerDetection").body_entered.connect(_on_body_entered)

## Essentially, when the player enteres the enemy's detection range,
## the enemy will start chasing after the player
func _on_body_entered(body: Node3D):
	if body is Player:
		finished.emit(CHASING)
