extends AnimatedSprite2D

var sprite_arr = ["base", "cutlines", "cut_1", "cut_2"]
var current_sprite = 0
var health = 10

@onready var cut_1 = $CutArea1
@onready var cut_2 = $CutArea2
var in_cut_1 = false
var in_cut_2 = false

# Called when the node enters the scene tree for the first time.
func _ready():
	play("cutlines")
	current_sprite = 1
	_connect_signals()

func _hovering_over_hitbox():
	if current_sprite == 1:
		return in_cut_1
	elif current_sprite == 2:
		return in_cut_2

func change_current_sprite(damage):
	if _hovering_over_hitbox():
		health -= damage
		if health <= 0:
			current_sprite = current_sprite + 1
			health = 10
			if(current_sprite > 3):
				current_sprite = 0
			play(sprite_arr[current_sprite])
	
func _connect_signals():
	cut_1.mouse_entered.connect(_on_cut_1_mouse_entered)
	cut_1.mouse_exited.connect(_on_cut_1_mouse_exited)
	cut_2.mouse_entered.connect(_on_cut_2_mouse_entered)
	cut_2.mouse_exited.connect(_on_cut_2_mouse_exited)

func _on_cut_1_mouse_entered():
	in_cut_1 = true
	print("amazing")

func _on_cut_1_mouse_exited():
	in_cut_1 = false

func _on_cut_2_mouse_entered():
	in_cut_2 = true

func _on_cut_2_mouse_exited():
	in_cut_2 = false
	
func get_sprite() -> int:
	return current_sprite
	
func reset():
	current_sprite = 1
	play(sprite_arr[current_sprite])
	health = 10
