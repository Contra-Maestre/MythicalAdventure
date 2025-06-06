extends Personajes

var directionPig = -1
var dmg := 1
@onready var rayGround : RayCast2D = $LimitRayCast/RayCast2DGround
@onready var rayWall : RayCast2D = $LimitRayCast/RayCast2DWall
@onready var rays : Node2D = $LimitRayCast
@onready var rayPlayer : RayCast2D = $LimitRayCast/RayCastPlayerDetector
@onready var animPig : AnimationPlayer = $AnimationPlayer
#var directionChange : bool = true - si quiero evitar caidas,
#creo una variable controladora y un nodo timer

enum estados{ANGRY, PATRULLAR,MORIR}
var estadoActual = estados.PATRULLAR

var player : CharacterBody2D

func _ready() -> void:
	animPig.play("walk")
	speed = 50

func _physics_process(delta: float) -> void:
	velocity.x = directionPig * speed
	if !is_on_floor():
		velocity.y += 9
	move_and_slide()

func _process(delta: float) -> void:
	if estadoActual == estados.PATRULLAR:
		if player == null and rayPlayer.is_colliding():
			var collision = rayPlayer.get_collider()
			if collision.is_in_group("player"):
				player = collision
				estadoActual = estados.ANGRY
	
	if estadoActual == estados.ANGRY:
		if player != null:
			animPig.play("runAngry")
			var directionPlayer = global_position.direction_to(player.global_position)
			if directionPlayer.x < 0: directionPig = -1
			elif directionPlayer.x > 0: directionPig = 1
	
	if rayWall.is_colliding(): #aqui uso un or para corroborar si estoy tocando el piso
		directionPig *= -1
		rays.scale *= -1
	$Sprite2D.flip_h = true if directionPig == 1 else false

func takeDmg(damage):
	life -= damage
	if life <= 0:
		$dmgPlayer/CollisionShape2D.set_deferred("disabled", true)
		estadoActual = estados.MORIR
		animPig.play("hurt")
		$CollisionShape2D.set_deferred("disabled", true)
		await (animPig.animation_finished)
		queue_free()


func _on_dmg_player_body_entered(body: Node2D) -> void:
	if body is Player:
		body.TakeDamage(dmg)
