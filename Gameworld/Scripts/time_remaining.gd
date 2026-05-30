extends ProgressBar

var game_master: GameMaster

func _ready() -> void:
	game_master = owner.owner.get_node("GameMaster") as GameMaster

func _process(_delta: float) -> void:
	value = game_master.round_timer.time_left * 100 / game_master.round_duration
