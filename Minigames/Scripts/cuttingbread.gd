extends Node2D

var sprite_arr = ["base", "cutlines", "cut_1", "cut_2"]
var current_sprite = 0;
@onready var bread_sprite = $BreadSprite

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_cut_bread()
	

func _cut_bread():
	if Input.is_action_just_pressed("cut"):
		_change_current_sprite()

func _change_current_sprite():
	current_sprite = current_sprite + 1
	if(current_sprite > 3):
		current_sprite = 0
	bread_sprite.play(sprite_arr[current_sprite])
