#@tool
extends Path2D

@export var speedPlatform : float = .2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$MovingPlatform.global_position = $PathFollow2D.global_position
	
	if $PathFollow2D.progress_ratio < 1:
		$PathFollow2D.progress_ratio += speedPlatform * delta
	else :
		$PathFollow2D.progress_ratio = 0
