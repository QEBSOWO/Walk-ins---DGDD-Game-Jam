extends EnemyState

var slime_drop = load("res://Gameworld/Scenes/slime_ingredient.tscn")
var crab_drop = load("res://Gameworld/Scenes/crab.tscn")

func enter(previous_state_path: String, data := {}) -> void:
	print(enemy.current_hp)
	enemy.anim_player.play("Death")
	if enemy.name == "Slime":
		var drop = slime_drop.instantiate()
		drop.global_position = enemy.global_position + Vector3(0, 1.5, 0)
		drop.freeze_object()
		get_tree().root.add_child(drop)
	if enemy.name == "Crab":
		var drop = crab_drop.instantiate()
		drop.global_position = enemy.global_position + Vector3(0, 1.5, 0)
		drop.freeze_object()
		get_tree().root.add_child(drop)
	await enemy.anim_player.animation_finished
	enemy.queue_free()
