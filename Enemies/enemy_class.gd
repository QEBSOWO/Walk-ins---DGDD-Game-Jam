class_name Enemy extends CharacterBody3D

@export var speed: float = 2.0
@export var is_armored: bool = false
@export var max_hp: int = 1
var current_hp: int

# Movement related variables
var nav_agent: NavigationAgent3D
var movement_target_position: Vector3 = Vector3(0.0, 0.0, 9.5)
var player: Player


# Grappling/Attack related variables
@onready var grapple_qte := $Sprite3D/SubViewport/GrappleQte
@export var grapple_windup: float = 1.0
@export var grapple_escape_force: float = 10.0
@export var knockback_duration: float = 0.2
@export var stagger_duration: float = 0.5

# State handling
var is_attacked: bool = false
var is_player_detected: bool = false
var is_player_in_attack_range: bool = false
var can_be_damaged: bool = true
var can_grapple: bool = true
var knockback_complete: bool = false


func initialize():
	# To be adjusted later for actor speed and navigation layout
	nav_agent.path_desired_distance = 0.5
	nav_agent.target_desired_distance = 0.5
	current_hp = max_hp
	
	# Get reference to player
	player = get_tree().root.get_child(0).get_node("Character") as Player
	assert(player != null, "Player could not be found during actor_setup")
	
	actor_setup.call_deferred()


func actor_setup():
	# Wait for first physics frame so NavigationServer can sync
	await get_tree().physics_frame
	
	# Now navigation map is no longer empty, set movement target
	set_movement_target(movement_target_position)


func set_movement_target(movement_target: Vector3):
	nav_agent.set_target_position(movement_target)


func handle_movement():
	if nav_agent.is_navigation_finished():
		return
	var current_agent_position: Vector3 = global_position
	var next_path_position: Vector3 = nav_agent.get_next_path_position()
	
	velocity = current_agent_position.direction_to(next_path_position) * speed
	look_at(Vector3(next_path_position.x, 0, next_path_position.z))
	move_and_slide()


func grapple_player():
	player.is_grappled = true
	print("Player grappled")
	await get_tree().create_timer(grapple_windup).timeout
	grapple_qte.start_qte()


func release_grappled_player():
	player.is_grappled = false
	is_player_in_attack_range = false
	print("Player cannot be grappled")


func take_damage(dmg: int = 1):
	print("Take damage")
	if is_armored:
		if player.is_active_weapon_armor_piercing():
			lose_hp(dmg)
		else:
			is_armored = false
	else:
		lose_hp(dmg)
	
	is_attacked = true
	can_be_damaged = false


func lose_hp(dmg: int = 1):
	current_hp -= dmg


func _unhandled_input(event: InputEvent) -> void:
	if grapple_qte.active and event.is_action_pressed("interact") and player.is_grappled:
		grapple_qte.end_qte(true) # On button press, qte ends successfully


func get_player_position() -> Vector3:
	return player.position
