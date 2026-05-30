class_name Player extends CharacterBody3D

@onready var pivot = $Pivot
@onready var weapon_holder = $Pivot/WeaponHolder
@onready var anim_player = $AnimationPlayer
@onready var model_animator = $Pivot/AnimationModel/AnimationPlayer
@onready var inventory = $PlayerHUD/Inventory
@onready var menu = $PlayerHUD/Menu
@export var speed: float = 5.0
@export var max_hp: int = 5
var current_hp: int
var is_grappled: bool = false
var is_aiming: bool = false
var can_move: bool = true
var can_be_grappled: bool = true
var active_weapon: Weapon
var input_dir: Vector2
var camera: Camera3D

# Attacking related variables
@onready var attack_zone: Area3D = $Pivot/AttackZone
@onready var zone_sprite := $Pivot/AttackZone/CollisionShape3D/ZoneSprite
@export var zone_aiming: Color = Color("3e94c9")
@export var zone_attacking: Color = Color("e60050")
@export var attack_cooldown: float = 0.5
var is_attacking: bool = false
var can_attack: bool = true

signal health_changed
signal died

func _ready() -> void:
	current_hp = max_hp
	camera = get_node("Node3D").get_node("Camera3D")
	zone_sprite.modulate = zone_aiming
	

func _process(_delta: float) -> void:
	if Engine.time_scale > 0:
		input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		
		if Input.is_action_just_pressed("aim"):
			if can_attack && active_weapon.visible:
				zone_sprite.visible = true
				is_aiming = true
			elif !active_weapon.visible:
				zone_sprite.visible = false
				is_aiming = false
		elif Input.is_action_just_released("aim"):
			zone_sprite.visible = false
			is_aiming = false
			
		
		if Input.is_action_pressed("attack") && can_attack && is_aiming && active_weapon.visible:
			can_attack = false
			is_attacking = true


func take_damage(dmg: int):
	current_hp -= dmg
	health_changed.emit()


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


func is_active_weapon_armor_piercing() -> bool:
	return active_weapon.is_armor_piercing


func end_game(rounds: int, end_message: String = "You died!") -> void:
	menu.end_screen.visible = true
	menu.reason_label.text = end_message
	menu.rounds_label.text = str(rounds)
	menu.show()
