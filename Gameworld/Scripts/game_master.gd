class_name GameMaster extends Node3D

@onready var serve_station = $"../ServeStations/serve_station"
@onready var enemy_spawners = $"../EnemySpawners"
@onready var round_timer = $RoundTimer
@onready var player = $"../Character"

var current_round: int = 1
var round_duration: float = 200
var enemy_spawner_array: Array[EnemySpawner]

func _ready() -> void:
	for spawner in enemy_spawners.get_children():
		enemy_spawner_array.append(spawner)
	
	round_timer.timeout.connect(_on_time_ran_out)
	player.died.connect(_end_game)
	
	await owner.ready
	start_new_round()


func start_new_round() -> void:
	round_timer.wait_time = round_duration
	if current_round > 1:
		adjust_enemy_spawners()
	
	round_timer.start()


func _on_time_ran_out() -> void:
	_end_game("You ran out of time")


func adjust_enemy_spawners() -> void:
	for spawner in enemy_spawner_array:
		var randpicker = randi_range(0, 3)
		if spawner.max_num_instances == 0:
			randpicker = 4
		match randpicker:
			0:
				print("Decrease respawn min")
				spawner.respawn_duration_min -= 0.2
				if spawner.respawn_duration_min < 0.3:
					spawner.respawn_duration_min = 0.3
			1:
				print("Decrease respawn max")
				spawner.respawn_duration_max -= 0.2
				if spawner.respawn_duration_max < 0.3:
					spawner.respawn_duration_max = 0.3
			2:
				print("Decrease spawn min")
				spawner.spawn_duration_min -= 0.2
				if spawner.spawn_duration_min < 0.3:
					spawner.spawn_duration_min = 0.3
			3:
				print("Decrease spawn max")
				spawner.spawn_duration_max -= 0.2
				if spawner.spawn_duration_max < 0.3:
					spawner.spawn_duration_max = 0.3
			4:
				print("Increase max instances")
				spawner.max_num_instances += 1
				if spawner.max_num_instances > 12:
					spawner.max_num_instances = 12


func _end_game(end_message: String = "You died") -> void:
	Engine.time_scale = 0
