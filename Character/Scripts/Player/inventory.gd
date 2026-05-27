extends Control

@onready var panel_base: StyleBoxFlat = preload("res://Character/Assets/Inventory/item_base.tres")
@onready var panel_selected: StyleBoxFlat = preload("res://Character/Assets/Inventory/item_selected.tres")
@onready var inventory_container: HBoxContainer = $WeaponContainer

var player: Player
var weapon_array: Array[Weapon]
var weapon_equipped_array: Array[bool] = [false, false] # Array for which weapons that are in inventory
var active_weapon: Weapon

func _ready() -> void:
	player = owner as Player
	assert(player != null, "Inventory not a child of Player. Player is missing or 
Inventory needs to be connected")
