extends Area3D

@onready var enemy = $".."

func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node3D):
	if body is Ingredient && !body.is_grabbed && !body.is_spawner:
		body.queue_free()
		enemy.is_attacked = true
