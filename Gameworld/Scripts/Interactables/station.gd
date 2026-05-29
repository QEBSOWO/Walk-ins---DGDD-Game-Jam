class_name Station extends Interactable

@export var items_on_table: Array[Ingredient]
var can_cook: bool
@export var max_items: int
@export var recipes = Resource
var cuttable = ["moss", "1l-oil", "Berries", "slime_ingredient", "bread"]
var fireable = ["crab", "water", "pot", "spice", "mug"]
var salad_scene = load("res://Gameworld/Scenes/salad.tscn")
var stew_scene = load("res://Gameworld/Scenes/stew.tscn")
var sandwich_scene = load("res://Gameworld/Scenes/sandwich.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	items_on_table = []
	can_cook = false

func interact(player_area: Area3D):
	var held_item = player_area.holding
	if held_item != null:
		if self is CuttingStation and str(held_item.get_child(0).name) in cuttable:
			if player_area.holding and items_on_table.size() < max_items:
				items_on_table.push_front(held_item)
				held_item.freeze_object()
				held_item.global_position = self.global_position + Vector3(0, 1, 0)
				can_cook = recipes.check_recipe(items_on_table)
		elif self is FireStation and str(held_item.get_child(0).name) in fireable:
			if player_area.holding and items_on_table.size() < max_items:
				items_on_table.push_front(held_item)
				held_item.freeze_object()
				held_item.global_position = self.global_position + Vector3(0, 1, 0)
				can_cook = recipes.check_recipe(items_on_table)
	else:
		if can_cook:
			var cooked_dish: String
			cooked_dish = recipes.get_cooked_dish()
			var new_dish
			if cooked_dish == "salad": new_dish = salad_scene.instantiate()
			elif cooked_dish == "stew": new_dish = stew_scene.instantiate()
			else: new_dish = sandwich_scene.instantiate()
			new_dish.global_position = self.global_position
			new_dish.interact(player_area)
			get_tree().root.get_child(0).add_child(new_dish)
			
			## MINIGAME HERE
			var character = player_area.owner
			var player_hud = character.get_child(4)
			var inventory = player_hud.get_child(0)
			var minigames = player_hud.get_child(1)
			var cutting = minigames.get_child(0)
			var pouring = minigames.get_child(1)
			var peeling = minigames.get_child(2)
			
			if self is CuttingStation and cooked_dish == "sandwich":
				cutting.show()
				pouring.hide()
				peeling.hide()
				
				cutting.enter(inventory.weapon_collected_array[0])
				
			if self is FireStation and cooked_dish == "stew":
				var station_has_mug = false
				cutting.hide()
				pouring.show()
				peeling.hide()
				
				for item in items_on_table:
					if str(item.get_child(0).name) == "mug":
						station_has_mug = true
					else: 
						station_has_mug = false
				
				if station_has_mug: pouring.enter(true)
				else: pouring.enter(false)
				
				pouring.minigame_finished.connect(
					func():
						cutting.hide()
						pouring.hide()
						peeling.show()
						
						peeling.enter(inventory.weapon_collected_array[1])
				)
			
			can_cook = false
			for item in items_on_table:
				item.queue_free()
			items_on_table.clear()

func release_item(player_area: Area3D):
	var recently_inserted = items_on_table.pop_front()
	recently_inserted.unfreeze_object()
	player_area.holding = recently_inserted
	recently_inserted.interact(player_area)
	
