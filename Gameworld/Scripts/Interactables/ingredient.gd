class_name Ingredient extends Interactable

var is_spawner: bool = true
var is_grabbed: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func interact(player_area: Area3D):
	# Grabbing an ingredient from a spawner
	if is_spawner:
		var ingredient_scene = load(scene_file_path)
		var new_ingredient = ingredient_scene.instantiate()
		add_child(new_ingredient)
		new_ingredient.reparent(self.get_parent())
		new_ingredient.player_area = player_area
		player_area.holding = new_ingredient
		new_ingredient.is_spawner = false
		new_ingredient.is_grabbed = true
		new_ingredient.collision_layer = 2
	
	# Sets the ingredient to be grabbed by the player
	# If grabbed, is placed on top of the player and follows 
	# If dropped, prevents player from colliding with instanced node
	if not is_spawner and not is_grabbed:
		player_area.holding = self
		unfreeze_object()
		is_grabbed = true
	else:
		freeze_object()
		is_grabbed = false

func _process(delta):
	if is_grabbed:
		self.global_position = player_area.global_position + Vector3(0, 1, 0)
		
func freeze_object():
	axis_lock_linear_x = true
	axis_lock_linear_z = true
	axis_lock_angular_x = true
	axis_lock_angular_y = true
	axis_lock_angular_z = true
	
func unfreeze_object():
	axis_lock_linear_x = false
	axis_lock_linear_z = false
	axis_lock_angular_x = false
	axis_lock_angular_y = false
	axis_lock_angular_z = false
