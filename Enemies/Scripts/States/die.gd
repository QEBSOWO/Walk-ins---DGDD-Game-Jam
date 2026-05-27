extends EnemyState

var death_drop = load("res://Gameworld/Scenes/barrel.tscn") # TODO: Replace with actual drop

func enter(previous_state_path: String, data := {}) -> void:
	var drop = death_drop.instantiate()
	drop.is_spawner = false
	drop.freeze_object()
	drop.global_position = enemy.global_position
	drop.collision_layer = 2
	owner.owner.add_child(drop)
	enemy.queue_free()
