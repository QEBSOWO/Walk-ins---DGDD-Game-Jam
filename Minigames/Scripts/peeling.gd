extends Node2D

var peeled = false
var peeler: AnimatedSprite2D
var over_peelee = true
@onready var hammer = $Hammer
@onready var peelee = $Crab
@onready var knife = $Knife

# Called when the node enters the scene tree for the first time.
func _ready():
	enter(false)

func enter(using_hammer):
	if(using_hammer): 
		peeler = hammer
		knife.visible = false
	else:
		peeler = knife
		hammer.visible = false
		

func _process(delta):
	_update_peeler_position()
	_handle_input()

func _handle_input():
	if Input.is_action_just_pressed("cut"):
		var damage = peeler.use()
		if(over_peelee):
			peelee.peel(damage)
			

func _update_peeler_position():
	peeler.position = get_global_mouse_position()

func _connect_signals():
	pass
