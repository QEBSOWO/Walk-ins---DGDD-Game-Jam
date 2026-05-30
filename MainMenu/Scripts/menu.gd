extends Control

@onready var return_button = $Button
@onready var end_screen = $EndScreen
@onready var reason_label = $EndScreen/ReasonLabel
@onready var rounds_label = $EndScreen/VBoxContainer/RoundsLabel
@onready var main_menu_scene = load("res://MainMenu/Scenes/main_menu.tscn")
var open = false

# Called when the node enters the scene tree for the first time.
func _ready():
	end_screen.visible = false
	_connect_signals()

func _process(delta):
	_handle_input()

func _connect_signals():
	return_button.pressed.connect(_on_return_button_pressed)

func _handle_input():
	if Input.is_action_just_pressed("open_menu"):
		if open:
			self.hide()
			open = false
			Engine.time_scale = 1
		else:
			self.show()
			open = true
			Engine.time_scale = 0

func _on_return_button_pressed():
	var instance = main_menu_scene.instantiate()
	get_tree().root.add_child(instance)
	get_tree().root.get_child(0).queue_free()
	end_screen.visible = false
