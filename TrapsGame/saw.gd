@tool
extends Node2D

var dmg := 3
var isRight = true
@export var speedSaw := .2
@onready var spriteSaw : Sprite2D = $CurrentSaw/SpriteOff
@onready var pathSaw :PathFollow2D = $Path2D/PathFollow2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	spriteSaw.rotate(deg_to_rad(10))
	$CurrentSaw.global_position = pathSaw.global_position
	
	if pathSaw.progress_ratio < 1:
		pathSaw.progress_ratio += speedSaw * delta
	else :
		pathSaw.progress_ratio -= speedSaw * delta
	
	if pathSaw.progress_ratio >= .95:
		isRight = false
	elif pathSaw.progress_ratio <= .05:
		isRight = true


func _on_dmg_player_body_entered(body: Node2D) -> void:
	if body is Player:
		body.TakeDamage(dmg)
