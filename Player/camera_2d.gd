extends Camera2D

func _ready() -> void:
	top_level = true

func _process(delta: float) -> void:
	global_position.x = get_parent().global_position.x
