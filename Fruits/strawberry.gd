extends Area2D

@onready var redEfect : CPUParticles2D = $CPUParticles2D

func _ready() -> void:
	redEfect.emitting = false

func _on_body_entered(body: Node2D) -> void:
	if body is Player: 
		$Sprite2D.hide()
		$CollisionShape2D.set_deferred("disabled", true)
		redEfect.emitting = true
		PruebaAuto.fruit += 1
		await (redEfect.finished)
		queue_free()
