extends Node2D

var sprite_arr = ["base", "cutlines", "cut_1", "cut_2"]
var current_sprite = 0;
var using_sword = false
var knife_positions = [0, 267, 381, 0]
var knife_cuts = 0;
@onready var bread_sprite = $BreadSprite
@onready var cutline = $Cutline

# Called when the node enters the scene tree for the first time.
func _ready():
	_change_current_sprite()
	cutline.play("base")
	pass

func enter():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_cut_bread(using_sword)
	_set_cutline_pos()

func _set_cutline_pos():
	cutline.position = get_global_mouse_position()

func _cut_bread(sword : bool):
	if Input.is_action_just_pressed("cut"):
		var mouse_x = get_global_mouse_position().x
		print(get_global_mouse_position())
		if (mouse_x < knife_positions[current_sprite] + 10
		and mouse_x > knife_positions[current_sprite] - 10):
			if(sword):
				_change_current_sprite()
			else:
				knife_cuts += 1
				if knife_cuts >= 10:
					_change_current_sprite()
					knife_cuts = 0

func _change_current_sprite():
	current_sprite = current_sprite + 1
	if(current_sprite > 3):
		current_sprite = 0
	bread_sprite.play(sprite_arr[current_sprite])
