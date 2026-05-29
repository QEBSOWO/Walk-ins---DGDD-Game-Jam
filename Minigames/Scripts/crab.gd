extends AnimatedSprite2D

var peeled = false
var health = 10
var hovered = false
@onready var crack_sfx = $CrackPlayer
@onready var small_crack_sfx = $SmallCrackPlayer
@onready var hitbox = $Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	play("default")
	_connect_signals()

func _process(delta):
	pass

func peel(damage):
	if hovered:
		health -= damage
		if(health <= 0):
			play("peeled")
			peeled = true
			crack_sfx.play()
			return
		else:
			small_crack_sfx.play()
	
func _on_mouse_entered():
	hovered = true

func _on_mouse_exited():
	hovered = false

func _connect_signals():
	hitbox.mouse_entered.connect(_on_mouse_entered)
	hitbox.mouse_exited.connect(_on_mouse_exited)
