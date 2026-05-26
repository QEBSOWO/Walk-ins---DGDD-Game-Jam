class_name Ingredient extends Interactable

var is_spawner: bool = true
var is_grabbed: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func interact(player: Player):
	if is_spawner:
		var ingredient_scene = load("res://Gameworld/Scenes/barrel.tscn")
		var new_ingredient = ingredient_scene.instantiate()
		add_child(new_ingredient)
		new_ingredient.reparent(self.get_parent())
		new_ingredient.player = player
		new_ingredient.is_spawner = false
		new_ingredient.is_grabbed = true
		new_ingredient.collision_layer = 2
	
	if not is_spawner and not is_grabbed:
		axis_lock_linear_x = false
		axis_lock_linear_z = false
		axis_lock_angular_x = false
		axis_lock_angular_y = false
		axis_lock_angular_z = false
		is_grabbed = true
	else:
		axis_lock_linear_x = true
		axis_lock_linear_z = true
		axis_lock_angular_x = true
		axis_lock_angular_y = true
		axis_lock_angular_z = true
		is_grabbed = false

func _process(delta):
	if is_grabbed:
		self.global_position = player.global_position + Vector3(0, 1, 0)
