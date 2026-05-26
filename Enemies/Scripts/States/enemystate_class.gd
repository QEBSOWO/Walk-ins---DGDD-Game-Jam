class_name EnemyState extends State

const SPAWNING = "Spawning"
const PATROLLING = "Patrolling"
const CHASING = "Chasing"
const GRAPPLING = "Grappling"
const DAMAGED = "Damaged"

var enemy: Enemy
var nav_agent: NavigationAgent3D
var player: Player


func _ready() -> void:
	await owner.ready
	enemy = owner as Enemy
	assert(enemy != null, "The EnemyState state type must be used only in the enemy scene. It needs the
owner to be an Enemy node")

	nav_agent = owner.get_node("NavigationAgent3D") as NavigationAgent3D
	assert(nav_agent != null, "The NavigationAgent3D node does not exist on this enemy. 
Ensure that a NavigationAgent3D node is a child of this enemy")
