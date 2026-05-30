extends Area3D

var interactables_in_range: Array[Interactable]
var holding: Interactable 	# to be used as reference for what player is holding
var held_interact_counter: float
var held_interact: bool
@onready var ingredient_player : AudioStreamPlayer2D = $"../IngredientPlayer"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactables_in_range = []
	held_interact_counter = 0.0
	held_interact = false
	
	# Connecting Signals
	self.body_entered.connect(_entered_interactable_area)
	self.body_exited.connect(_exited_interactable_area)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("interact") and held_interact == false:
		var interactable = get_closest_interactable()
		
		# If player is not holding anything, pick up from spawner or ground
		# If player is holding something, prevent other items from being picked up
		if interactable is Ingredient:
			if not holding: 
				interactable.interact(self)
				_play_ingredient_audio()
			else:
				if interactable.is_grabbed == true:
					interactable.interact(self)
					holding = null
					
		if interactable is Station:
			if holding:
				interactable.interact(self)
				holding.freeze_object()
				holding.is_grabbed = false
				holding = null
			else:
				interactable.interact(self)
				
	if Input.is_action_pressed("interact"):
		var interactable = get_closest_interactable()
		
		if interactable is Station and not holding:
			held_interact_counter += delta
			if held_interact_counter > 1.0:
				held_interact = true
				interactable.release_item(self)
				Input.action_release("interact")
	elif Input.is_action_just_released("interact") and holding:
		held_interact = false
	else: held_interact_counter = 0.0

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

func _play_ingredient_audio():
	if !ingredient_player.playing:
		ingredient_player.play()
