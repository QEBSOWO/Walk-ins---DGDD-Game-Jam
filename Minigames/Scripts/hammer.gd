extends AnimatedSprite2D

@onready var timer = $Timer
var peeling = false
var damage = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.timeout.connect(_on_timer_timeout)


func use():
	if !peeling:
		play("peel")
		peeling = true
		timer.start()
		return damage
	else: return 0
	
func _on_timer_timeout():
	peeling = false
