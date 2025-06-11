extends Area2D

@export var nextLevel : String 

signal TrueLight

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		emit_signal("TrueLight")
		get_tree().change_scene_to_file(nextLevel)
