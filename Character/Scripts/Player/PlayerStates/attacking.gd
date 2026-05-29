extends PlayerState

var aiming_speed: float
var has_hit: bool

func enter(previous_state_path: String, data := {}) -> void:
	player.zone_sprite.modulate = player.zone_attacking
	aiming_speed = player.speed/2
	player.anim_player.play("attack")
	has_hit = false
	player.anim_player.animation_finished.connect(_on_animation_finished)


func physics_update(_delta: float) -> void:
	player.handle_rotation()
	player.handle_movement(aiming_speed)
	for body in player.attack_zone.get_overlapping_bodies():
		if body is Enemy && body.can_be_damaged:
			body.take_damage()
			has_hit = true
	
	if player.is_grappled:
		finished.emit(GRAPPLED)


func _on_animation_finished(_anim_name: StringName) -> void:
	player.is_attacking = false
	
	if (player.input_dir.x != 0 or player.input_dir.y != 0) && player.can_move:
		finished.emit(MOVING)
	elif player.is_aiming:
		finished.emit(AIMING)
	else:
		finished.emit(IDLE)
	
	await get_tree().create_timer(player.attack_cooldown).timeout
	player.can_attack = true

func exit() -> void:
	player.zone_sprite.modulate = player.zone_aiming
	if has_hit:
		player.inventory.decrease_equipped_durability()
