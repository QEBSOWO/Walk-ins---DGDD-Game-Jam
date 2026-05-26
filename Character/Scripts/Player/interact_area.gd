extends Area3D

var interactables_in_range: Array[Interactable]
var holding: Interactable 	# to be used as reference for what player is holding

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactables_in_range = []
	
	# Connecting Signals
	self.body_entered.connect(_entered_interactable_area)
	self.body_exited.connect(_exited_interactable_area)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("interact"):
		var interactable = get_closest_interactable()
		
		# If player is not holding anything, pick up from spawner or ground
		# If player is holding something, prevent other items from being picked up
		if not holding:
			if interactable is Ingredient:
				interactable.interact(self)
				holding = interactable
		else:
			if interactable.is_grabbed == true:
				interactable.interact(self)
				holding = null

## Calculates the interactable object closest to the player
func get_closest_interactable() -> Interactable:
	var closest: Interactable = null
	var closest_distance := INF
	
	for interactable in interactables_in_range:
		if not is_instance_valid(interactable):
			continue
		
		var distance = global_position.distance_to(interactable.global_position)
		
		if distance < closest_distance:
			closest_distance = distance
			closest = interactable
			
	return closest
	

func _entered_interactable_area(body):
	if body is Interactable:
		interactables_in_range.append(body)
		
func _exited_interactable_area(body):
	if body is Interactable:
		interactables_in_range.erase(body)
