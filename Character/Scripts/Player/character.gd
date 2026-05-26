class_name Player extends CharacterBody3D

@export var speed: float = 5.0
@export var max_hp: int = 5
var current_hp: int
var is_grappled: bool = false

func _ready() -> void:
	current_hp = max_hp
	
func _process(delta):
	pass
