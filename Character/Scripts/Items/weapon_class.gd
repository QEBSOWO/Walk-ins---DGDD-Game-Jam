class_name Weapon extends Interactable

@export var is_armor_piercing: bool = false
@export var durability: int = 1

var damage: int = 1

func interact(player_area):
	var player = player_area.owner
	var player_inventory = player.get_node("PlayerHUD/Inventory")
	if self.get_child(0).name == "hammer_A2":
		print("picked up hammer")
		player_inventory.collect_weapon(1)
	elif self.get_child(0).name == "sword_B2":
		print("picked up sword")
		player_inventory.collect_weapon(0)
