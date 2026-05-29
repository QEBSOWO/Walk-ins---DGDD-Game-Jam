extends Control

@onready var weapon_container: HBoxContainer = $WeaponContainer
var panel_container_array: Array[PanelContainer]

var player: Player
var weapon_array: Array[Weapon]
var weapon_collected_array: Array[bool] = [true, false] # Array for which weapons that are in inventory

func _ready() -> void:
	player = owner as Player
	assert(player != null, "Inventory not a child of Player. Player is missing or 
Inventory needs to be connected")
	
	for weapon in player.get_node("Pivot").get_node("WeaponHolder").get_children():
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
		player.can_attack = true
		player.active_weapon.visible = true
		weapon_array[index-1].visible = false
	
	elif !weapon_collected_array[index]:
		player.can_attack = false
		player.active_weapon.visible = false
		weapon_array[index-1].visible = false


func _process(_delta: float) -> void:
	if !player.is_attacking:
		if Input.is_action_pressed("equip_first"):
			equip_slot(0)
		elif Input.is_action_pressed("equip_second"):
			equip_slot(1)
	
	var i: int = 0
	for panel in panel_container_array:
		if weapon_collected_array[i]:
			panel.get_node("WeaponIcon").modulate = Color("ffffff")
		else:
			panel.get_node("WeaponIcon").modulate = Color("020229")
		i += 1


func decrease_equipped_durability() -> void:
	player.active_weapon.durability -= 1
	if player.active_weapon.durability <= 0:
		var to_remove: int = weapon_array.find(player.active_weapon)
		weapon_array[to_remove].visible = false
		weapon_collected_array[to_remove] = false
		
		if weapon_collected_array[to_remove-1]:
			if to_remove == 0:
				equip_slot(1)
			elif to_remove == 1:
				equip_slot(0)
