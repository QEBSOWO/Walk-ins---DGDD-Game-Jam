class_name Player extends CharacterBody3D

@onready var pivot = $Pivot
@export var speed: float = 5.0
@export var max_hp: int = 5
var current_hp: int
var is_grappled: bool = false
var active_weapon: Weapon
var input_dir: Vector2

func _ready() -> void:
	current_hp = max_hp

func _process(_delta: float) -> void:
	input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")

func take_damage(dmg: int):
	current_hp -= dmg

func handle_movement(move_speed: float = self.speed):
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * move_speed
		velocity.z = direction.z * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
		velocity.z = move_toward(velocity.z, 0, move_speed)
	
	move_and_slide()

func handle_rotation(dir_vector: Vector3) -> void:
	pivot.look_at(global_position - dir_vector)
