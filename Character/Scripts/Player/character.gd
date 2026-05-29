class_name Player extends CharacterBody3D

@onready var pivot = $Pivot
@onready var weapon_holder = $Pivot/WeaponHolder
@onready var anim_player = $AnimationPlayer
@onready var model_animator = $Pivot/AnimationModel/AnimationPlayer
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
	
	if Input.is_action_pressed("aim") && can_attack:
		is_aiming = true
	elif Input.is_action_just_released("aim"):
		is_aiming = false
	
	if Input.is_action_pressed("attack") && can_attack && is_aiming:
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
	var mouse_position = get_viewport().get_mouse_position()
	var ray_origin = camera.project_ray_origin(mouse_position)
	var ray_target = ray_origin + camera.project_ray_normal(mouse_position) * 2000
	
	var intersection = _handle_space_state(ray_origin, ray_target)
	
	if not intersection.is_empty():
		var pos = intersection.position
		var look_at_me = Vector3(pos.x, pivot.position.y, pos.z)
		pivot.look_at(-look_at_me, Vector3.UP)


func is_active_weapon_armor_piercing() -> bool:
	return active_weapon.is_armor_piercing


func _handle_space_state(ray_origin, ray_target) -> Dictionary:
	var space_state = get_world_3d().direct_space_state
	var params = PhysicsRayQueryParameters3D.new()
	params.from = ray_origin
	params.to = ray_target
	params.exclude = []
	params.collision_mask = 1
	var result = space_state.intersect_ray(params)
	
	return result
