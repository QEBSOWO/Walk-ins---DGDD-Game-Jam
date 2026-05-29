extends Control

@onready var QTE = $GrappleQte

func _ready() -> void:
	QTE.failed_input.connect(_on_failed_input)
	QTE.successful_input.connect(_on_succeed_input)

func _on_failed_input():
	print("Failed Input")

func _on_succeed_input():
	print("Succeeded Input")

func _input(event):
	if event.is_action_pressed("move_down"):
		QTE.start_qte()
