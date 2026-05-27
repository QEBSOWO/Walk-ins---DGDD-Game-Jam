class_name Station extends Interactable

var item_on_table: Interactable

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func interact(player_area: Area3D):
	if player_area.holding:
		var held_item = player_area.holding
		item_on_table = held_item
		item_on_table.global_position = self.global_position + Vector3(0, 0.5, 0)
		item_on_table.freeze_object()
	else:
		if item_on_table:
			print("Entered cooking minigame")

func release_item(player_area: Area3D):
	item_on_table.unfreeze_object()
	player_area.holding = item_on_table
	item_on_table.interact(player_area)
