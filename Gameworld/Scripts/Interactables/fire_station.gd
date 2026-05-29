class_name FireStation extends Station


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	valid_cook_items = ["res://Gameworld/Scenes/barrel.tscn"] # TODO: Fill with cuttable ingredients
	max_items = 4

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
