extends PlayerState

var aiming_speed: float

func enter(previous_state_path: String, data := {}) -> void:
	aiming_speed = player.speed/2
	player.anim_player.play("attack")
	player.can_attack = false
	player.anim_player.animation_finished.connect(_on_animation_finished)


func physics_update(_delta: float) -> void:
	player.look_at_cursor()
	player.handle_movement(aiming_speed)
	# TODO: Handle damage
	for body in player.attack_zone.get_overlapping_bodies():
		if body is Enemy:
			body.is_attacked = true
			body.take_damage(1)
			body.velocity = (body.position-body.player.position).normalized() * 2 * body.grapple_escape_force
	
	if player.is_grappled:
		finished.emit(GRAPPLED)


func exit() -> void:
	player.can_attack = true
	player.is_attacking = false


func _on_animation_finished(_anim_name: StringName) -> void:
	if player.input_dir.x != 0 or player.input_dir.y != 0:
		finished.emit(MOVING)
	elif player.is_aiming:
		finished.emit(AIMING)
	else:
		finished.emit(IDLE)
	
