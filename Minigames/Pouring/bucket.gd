extends AnimatedSprite2D

var water_state = 3
var water_states = ["default", "third", "half", "full"]

# Called when the node enters the scene tree for the first time.
func _ready():
	play("full")


func adjust_water_level():
	water_state -= 1
	water_state = max(water_state, 0)
	play(water_states[water_state])

func get_water_level():
	return water_state

func reset():
	water_state = 3
	play(water_states[water_state])
