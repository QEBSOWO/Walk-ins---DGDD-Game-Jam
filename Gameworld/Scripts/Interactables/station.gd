class_name Station extends Interactable

@export var items_on_table: Array[Ingredient]
var can_cook: bool
@export var max_items: int
@export var recipes = Resource
var cuttable = ["moss", "1l-oil", "Berries", "slime_ingredient", "bread"]
var fireable = ["crab", "water", "water2", "pot", "spice"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	items_on_table = []
	can_cook = false

func interact(player_area: Area3D):
	var held_item = player_area.holding
	if held_item != null:
		if self is CuttingStation and str(held_item.name) in cuttable:
			if player_area.holding and items_on_table.size() < max_items:
				items_on_table.push_front(held_item)
				held_item.freeze_object()
				held_item.global_position = self.global_position + Vector3(0, 1, 0)
				can_cook = recipes.check_recipe(items_on_table)
		elif self is FireStation and str(held_item.name) in fireable:
			if player_area.holding and items_on_table.size() < max_items:
				items_on_table.push_front(held_item)
				held_item.freeze_object()
				held_item.global_position = self.global_position + Vector3(0, 1, 0)
				can_cook = recipes.check_recipe(items_on_table)
	else:
		can_cook = recipes.check_recipe(items_on_table)
		if can_cook: 
			var cooked_dish: PackedScene
			cooked_dish = load(recipes.get_cooked_dish())
			var new_dish = cooked_dish.instantiate()
			new_dish.global_position = self.global_position
			new_dish.interact(player_area)
			get_tree().root.get_child(0).add_child(new_dish)
			can_cook = false
			for item in items_on_table:
				item.queue_free()
			items_on_table.clear()

func release_item(player_area: Area3D):
	var recently_inserted = items_on_table.pop_front()
	recently_inserted.unfreeze_object()
	player_area.holding = recently_inserted
	recently_inserted.interact(player_area)
