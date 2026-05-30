extends Marker3D

@onready var cooldown: Timer = $Cooldown

@export var weapon: PackedScene

var current_num_instances: int = 0
var has_space: bool = true


func _ready() -> void:
	weapon = load(weapon.get_path())
	cooldown.timeout.connect(_on_cooldown_timer_timeout)


func spawn_weapon() -> void:
	has_space = false
	var spawned_weapon: Weapon = weapon.instantiate()
	spawned_weapon.rotation_degrees = Vector3(0, randi_range(-30, 30), -150)
	spawned_weapon.position = Vector3(0, 0.6, 0.0)
	add_child(spawned_weapon)
	
	spawned_weapon.tree_exited.connect(_on_player_pickup)
	
func _on_player_pickup() -> void:
	has_space = true


func _on_cooldown_timer_timeout() -> void:
	if has_space:
		spawn_weapon()
	cooldown.start()
