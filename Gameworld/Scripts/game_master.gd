class_name GameMaster extends Node3D

@onready var serve_station = $"../ServeStations/serve_station"
@onready var enemy_spawners = $"../EnemySpawners"
@onready var round_timer = $RoundTimer
@onready var player = $"../Character"

const MAX_ORDERS: int = 8

var num_orders: int = 0
var current_round: int = 1
var round_duration: float = 120
var enemy_spawner_array: Array[EnemySpawner]
var round_label : Label

func _ready() -> void:
	for spawner in enemy_spawners.get_children():
		enemy_spawner_array.append(spawner)
	
	round_timer.timeout.connect(_on_time_ran_out)
	player.died.connect(_end_game)
	serve_station.all_orders_complete.connect(_end_round)
	
	round_label = player.get_node("PlayerHUD").get_node("RoundNumber").get_node("RoundLabel")
	
	await owner.ready
	start_new_round()


func start_new_round() -> void:
	if current_round > 1:
		adjust_enemy_spawners()
		if num_orders < MAX_ORDERS:
			num_orders += 1
			round_duration += 10
		else:
			round_duration -= 15
	
	round_label.text = str(current_round)
	round_timer.wait_time = round_duration
	
	for i in range(num_orders):
		_setup_orders()
	
	round_timer.start()


func _end_round() -> void:
	if !round_timer.is_stopped():
		round_timer.stop()
		for spawner in enemy_spawners.get_children():
			for enemy in spawner.get_children():
				enemy.queue_free()
		
		current_round += 1
		await get_tree().create_timer(3).timeout
		start_new_round()


func _on_time_ran_out() -> void:
	_end_game("You ran out of time")


func _on_all_orders_complete() -> void:
	if round_timer.time_left >= 0 && player.current_hp > 0:
		_end_round()


func adjust_enemy_spawners() -> void:
	for spawner in enemy_spawner_array:
		var randpicker = randi_range(0, 3)
		if spawner.max_num_instances == 0:
			randpicker = 4
		match randpicker:
			0:
				spawner.respawn_duration_min -= 0.2
				if spawner.respawn_duration_min < 0.3:
					spawner.respawn_duration_min = 0.3
			1:
				spawner.respawn_duration_max -= 0.2
				if spawner.respawn_duration_max < 0.3:
					spawner.respawn_duration_max = 0.3
			2:
				spawner.spawn_duration_min -= 0.2
				if spawner.spawn_duration_min < 0.3:
					spawner.spawn_duration_min = 0.3
			3:
				spawner.spawn_duration_max -= 0.2
				if spawner.spawn_duration_max < 0.3:
					spawner.spawn_duration_max = 0.3
			4:
				spawner.max_num_instances += 1
				if spawner.max_num_instances > 12:
					spawner.max_num_instances = 12


func _setup_orders() -> void:
	var rand_order = randi_range(0, 2)
	match rand_order:
		0:
			serve_station.add_order("Salad")
		1:
			serve_station.add_order("Stew")
		2:
			serve_station.add_order("Sandwich")


func _end_game(end_message: String = "You died") -> void:
	Engine.time_scale = 0
