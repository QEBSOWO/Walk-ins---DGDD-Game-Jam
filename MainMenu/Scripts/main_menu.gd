extends Control

@onready var button = $Button
@onready var gameworld = load("res://Gameworld/Scenes/FinalWorld.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	_connect_signals()

func _connect_signals():
	button.pressed.connect(_on_button_pressed)
	
func _on_button_pressed():
	var instance = gameworld.instantiate()
	get_tree().root.add_child(instance)
	self.queue_free()
	
