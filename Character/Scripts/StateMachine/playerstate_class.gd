class_name PlayerState extends State

const IDLE = "Idle"
const MOVING = "Moving"
const COOKING = "Cooking" # This is the state for when the player's in a minigame

# Combat related states
const AIMING = "Aiming"
const ATTACKING = "Attacking"
const DAMAGED = "Damaged"

var player: Player


func _ready() -> void:
	await owner.ready
	player = owner as Player
	assert(player != null, "The PlayerState state type must be used only in the player scene. It needs the
owner to be a Player node")
