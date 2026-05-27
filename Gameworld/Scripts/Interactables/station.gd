class_name Station extends Interactable

@export var items_on_table: Array[Interactable]
var valid_cook_items: Array[String] # Stores scene file paths for valid items 
@export var max_items: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	items_on_table = []
	valid_cook_items = []

func interact(player_area: Area3D):
	var held_item = player_area.holding
	if player_area.holding and items_on_table.size() < max_items:
		items_on_table.push_front(held_item)
		held_item.freeze_object()
		held_item.global_position = self.global_position + Vector3(0, 0.5, 0)
		print(str(items_on_table.size()) + "/" + str(max_items))
	else:
		var can_cook: bool = false
		
		for item in items_on_table:
			if valid_cook_items.has(item.scene_file_path):
				can_cook = true
			else:
				can_cook = false
				break
		
		if can_cook: print("Cooking minigame here")

func release_item(player_area: Area3D):
	var recently_inserted = items_on_table.pop_front()
	recently_inserted.unfreeze_object()
	player_area.holding = recently_inserted
	recently_inserted.interact(player_area)
