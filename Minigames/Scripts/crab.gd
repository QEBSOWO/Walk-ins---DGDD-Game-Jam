extends AnimatedSprite2D

var peeled = false
var health = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	play("default")


func peel(damage):
	health -= damage
	if(health <= 0):
		play("peeled")
		peeled = true
