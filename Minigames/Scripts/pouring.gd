extends Node2D

@onready var spoon : AnimatedSprite2D = $Spoon
@onready var ladle : AnimatedSprite2D = $Ladle
@onready var bucket : AnimatedSprite2D = $Bucket
@onready var bucket_area : Area2D = $Bucket/Area2D
@onready var cauldron : AnimatedSprite2D = $Cauldron
@onready var cauldron_area : Area2D = $Cauldron/Area2D
var pourer: AnimatedSprite2D
var pour_weight = 1
var bucket_treshold = 0
var using_ladle = false
var in_bucket = false
var in_cauldron = false

# Called when the node enters the scene tree for the first time.
func _ready():
	enter(false)
	_connect_signals()

func enter(is_ladle):
	using_ladle = is_ladle
	if(is_ladle):
		pourer = ladle
		spoon.visible = false
		pour_weight = 3
	else:
		pourer = self.spoon
		ladle.visible = false
		pour_weight = 1
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_handle_input()
	_set_spoon_pos()

func _handle_input():
	if Input.is_action_just_pressed("cut"):
		if in_bucket:
			if bucket.get_water_level() != 0: 
				pourer.play("water")
				bucket_treshold += pour_weight
				if bucket_treshold >= 3: 
					bucket.adjust_water_level()
					bucket_treshold = 0
		elif in_cauldron:
			pourer.play("default")
		else: pourer.play("default")

func _set_spoon_pos():
	if ladle:
		pourer.position = get_global_mouse_position() + Vector2(50, -100)
	else:
		pourer.position = get_global_mouse_position() + Vector2(0, 135)

func _connect_signals():
	bucket_area.mouse_entered.connect(_on_bucket_area_mouse_entered)
	bucket_area.mouse_exited.connect(_on_bucket_area_mouse_exited)
	cauldron_area.mouse_entered.connect(_on_cauldron_area_mouse_entered)
	cauldron_area.mouse_exited.connect(_on_cauldron_area_mouse_exited)

func _on_bucket_area_mouse_entered():
	in_bucket = true

func _on_bucket_area_mouse_exited():
	in_bucket = false

func _on_cauldron_area_mouse_entered():
	in_cauldron = true

func _on_cauldron_area_mouse_exited():
	in_cauldron = false
