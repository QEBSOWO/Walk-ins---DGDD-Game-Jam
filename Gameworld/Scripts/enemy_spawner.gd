extends Marker3D

@export var enemy: PackedScene
@export var respawn_duration: float = 1.0
var active_enemy: Enemy

func _ready() -> void:
	enemy = load(enemy.get_path())
	spawn_enemy()

func spawn_enemy() -> void:
	active_enemy = enemy.instantiate()
	add_child(active_enemy)
	print("Spawned Enemy")
