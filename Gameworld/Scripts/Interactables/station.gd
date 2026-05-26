class_name Station extends Interactable

var item_on_table: Interactable

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func interact(player: Player):
	if player.holding:
		var held_item = player.holding
		item_on_table = held_item
