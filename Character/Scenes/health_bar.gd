extends TextureProgressBar

var player: Player

func _ready() -> void:
	await owner.ready
	player = owner as Player
	update_health()
	player.health_changed.connect(update_health)

func update_health():
	value = player.current_hp * 100 / player.max_hp
