class_name Player extends CharacterBody3D

@export var speed: float = 5.0
@export var max_hp: int = 5
var current_hp: int
var interactables_in_range: Array[Interactable]
var interact_area: Area3D

func _ready() -> void:
	current_hp = max_hp
	interactables_in_range = [] 	# Keep array of interactable objects local to character
	interact_area = $InteractArea
	
	# Connecting Signals
	interact_area.body_entered.connect(_entered_interactable_area)
	interact_area.body_exited.connect(_exited_interactable_area)
	
func _process(delta):
	if Input.is_action_just_pressed("interact"):
		var interactable = get_closest_interactable()
		
		# Replace with grabbing
		if interactable:
			interactable.interact()

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
	if body.get_parent() is Interactable:
		interactables_in_range.append(body.get_parent())
		
func _exited_interactable_area(body):
	if body.get_parent() is Interactable:
		interactables_in_range.erase(body.get_parent())
