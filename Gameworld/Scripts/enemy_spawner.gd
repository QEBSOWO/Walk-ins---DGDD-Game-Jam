extends Marker3D

@onready var mob_timer: Timer = $MobTimer

@export var enemy: PackedScene
@export var respawn_duration_min: float = 2
@export var respawn_duration_max: float = 5

@export var spawn_duration_min: float = 5
@export var spawn_duration_max: float = 10

@export var max_num_instances: int = 3

var current_num_instances: int = 0

func _ready() -> void:
	enemy = load(enemy.get_path())
	mob_timer.timeout.connect(_on_mob_timer_timeout)


func spawn_enemy() -> void:
	var spawned_enemy: Enemy = enemy.instantiate()
	add_child(spawned_enemy)
	spawned_enemy.tree_exited.connect(_on_enemy_death)
	current_num_instances += 1


func _on_enemy_death() -> void:
	current_num_instances -= 1


func _on_mob_timer_timeout() -> void:
	if current_num_instances < max_num_instances:
		spawn_enemy()
	mob_timer.wait_time = randf_range(spawn_duration_min, spawn_duration_max)
	mob_timer.start()
