class_name Player extends CharacterBody3D

@export var speed: float = 5.0
@export var max_hp: int = 5
var current_hp: int

signal grappled

func _ready() -> void:
	current_hp = max_hp
