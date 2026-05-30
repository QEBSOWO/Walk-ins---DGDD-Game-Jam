class_name Weapon extends Interactable

@export var is_armor_piercing: bool = false
@export var durability: int = 1

var damage: int = 1
var player: Player
var inventory: Control

func interact(player_area):
	var player = player_area.owner
	var player_inventory = player.get_node("PlayerHUD/Inventory")
	if self.get_child(0).name == "hammer_A2":
		if not player_inventory.weapon_collected_array[1]:
			player_inventory.collect_weapon(1)
			self.queue_free()
	elif self.get_child(0).name == "sword_B2":
		if not player_inventory.weapon_collected_array[0]:
			player_inventory.collect_weapon(0)
			self.queue_free()
