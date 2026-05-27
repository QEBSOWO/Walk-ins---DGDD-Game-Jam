extends Control
class_name QuickTimeEvent

@export var duration := 1
var active: bool # Used to know if qte is still accepting input

@onready var color_rect: ColorRect = $ColorRect
@onready var key_label: Label = $ColorRect/KeyLabel
@onready var timer

signal successful_input
signal failed_input

var tween = create_tween()

func start_qte():
	timer = get_tree().create_timer(duration)
	timer.timeout.connect(end_qte)
	active = true
	#tween.tween_property(color_rect, "material:shader_paremeter/progress", 0, duration)

func end_qte(successful: bool = false):
	active = false # Stop accepting input
	
	if successful:
		emit_signal("successful_input")
		tween.kill()
	else:
		emit_signal("failed_input")
	
	timer.timeout.disconnect(end_qte)

func _input(event):
	if active and event.is_action_pressed("interact"):
		end_qte(true) # On button press, qte ends successfully
