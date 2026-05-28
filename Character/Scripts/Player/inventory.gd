extends Control

@onready var weapon_container: HBoxContainer = $WeaponContainer
var panel_container_array: Array[PanelContainer]

var player: Player
var weapon_array: Array[Weapon]
var weapon_collected_array: Array[bool] = [true, true] # Array for which weapons that are in inventory

func _ready() -> void:
	player = owner as Player
	assert(player != null, "Inventory not a child of Player. Player is missing or 
Inventory needs to be connected")
	
	for weapon in player.get_node("WeaponHolder").get_children():
		weapon_array.append(weapon)
		weapon.visible = false
	
	for panel in weapon_container.get_children():
		panel_container_array.append(panel)
	
	equip_slot(0)


func equip_slot(index: int) -> void:
	player.active_weapon = weapon_array[index]
	panel_container_array[index].get_node("InventoryOutline").visible = true
	panel_container_array[index-1].get_node("InventoryOutline").visible = false
	
	if weapon_collected_array[index]:
		player.active_weapon.visible = true


func _process(_delta: float) -> void:
	if Input.is_action_pressed("equip_first"):
		equip_slot(0)
	elif Input.is_action_pressed("equip_second"):
		equip_slot(1)
