class_name EnemyState extends State

const SPAWNING = "Spawning"
const PATROLLING = "Patrolling"
const CHASING = "Chasing"
const GRAPPLING = "Grappling"
const DAMAGED = "Damaged"

var enemy: Enemy

var is_player_detected: bool = false

func _ready() -> void:
	await owner.ready
	enemy = owner as Enemy
	assert(enemy != null, "The EnemyState state type must be used only in the enemy scene. It needs the
owner to be an Enemy node")

	enemy.nav_agent = owner.get_node("NavigationAgent3D") as NavigationAgent3D
	assert(enemy.nav_agent != null, "The NavigationAgent3D node does not exist on this enemy. 
Ensure that a NavigationAgent3D node is a child of an enemy")

	_connect_signals()

func _connect_signals():
	enemy.get_node("PlayerDetection").body_entered.connect(_on_DetectionRange_entered)

## Essentially, when the player enteres the enemy's detection range,
## the enemy will start chasing after the player
func _on_DetectionRange_entered(body: Node3D):
	if body is Player:
		is_player_detected = true

func _on_DetectionRange_exited(body: Node3D):
	if body is Player:
		is_player_detected = false

func is_detecting_player() -> bool:
	return is_player_detected
