class_name Cutting
extends Node2D

var sprite_arr = ["base", "cutlines", "cut_1", "cut_2"]
var current_sprite = 0;
var using_sword = false
var knife_positions = [0, 267, 381, 0]
var knife_cuts = 0;
var cutting = false;
var damage = 1
@onready var bread_sprite = $BreadSprite
@onready var knife = $Knife
@onready var sword = $Sword
@onready var timer = $Timer

var cutter : AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	bread_sprite.play("cutlines")
	enter(false)

func enter(has_sword):
	self.using_sword = has_sword
	if using_sword:
		cutter = sword
		sword.show()
		knife.hide()
		damage = 10
	else:
		cutter = knife
		sword.hide()
		knife.show()
		damage = 1
	cutter.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer.timeout.connect(_on_timer_timeout)
	_cut_bread(using_sword)
	_set_cutline_pos()

func _set_cutline_pos():
	cutter.global_position = get_global_mouse_position()

func _cut_bread(sword : bool):
	if Input.is_action_just_pressed("cut") and not cutting:
		cutting = true;
		timer.start()
		cutter.play("cutline")
		var mouse_x = get_global_mouse_position().x
		bread_sprite.change_current_sprite(damage)
		check_current_sprite()

func _change_current_sprite():
	current_sprite = current_sprite + 1
	if(current_sprite > 3):
		current_sprite = 0
	bread_sprite.play(sprite_arr[current_sprite])

func _on_timer_timeout():
	cutting = false;
	
func check_current_sprite():
	current_sprite = bread_sprite.get_sprite()
	if current_sprite >= 3: exit()

func exit():
	var exit_timer = $ExitTimer
	exit_timer.timeout.connect(func(): 
		self.hide()
		bread_sprite.reset()
		)
	exit_timer.start()
	
