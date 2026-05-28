class_name Player extends CharacterBody3D

@onready var pivot = $Pivot
@onready var weapon_holder = $Pivot/WeaponHolder
@onready var anim_player = $AnimationPlayer
@export var speed: float = 5.0
@export var max_hp: int = 5
var current_hp: int
var is_grappled: bool = false
var is_aiming: bool = false
var active_weapon: Weapon
var input_dir: Vector2
var camera: Camera3D

# Attacking related variables
@onready var attack_zone: Area3D = $Pivot/AttackZone
var is_attacking: bool = false
var can_attack: bool = true

func _ready() -> void:
	current_hp = max_hp
	camera = owner.get_node("Node3D").get_node("Camera3D")

func _process(_delta: float) -> void:
	input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if Input.is_action_pressed("aim"):
		is_aiming = true
	elif Input.is_action_just_released("aim"):
		is_aiming = false
	
	if Input.is_action_pressed("attack") && can_attack:
		can_attack = false
		is_attacking = true


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


func handle_rotation() -> void:
	pivot.look_at(global_position - Vector3(input_dir.x, 0, input_dir.y))


func look_at_cursor() -> void:
	var target_plane_mouse = Plane(Vector3(0,1,0), position.y)
	var ray_length = 1000
	var mouse_pos = get_viewport().get_mouse_position()
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * ray_length
	var cursor_pos_on_plane = target_plane_mouse.intersects_ray(from, to)
	
	pivot.look_at(-cursor_pos_on_plane, Vector3.UP, 0)
