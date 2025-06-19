extends CharacterBody2D
class_name Player

@export var speed : int = 12000
var direction = 0.0
const  gravity : float = 10.0
var numJumps := 0
@export var jumpForce : float = 250.0
@export var damage : int = 1
var life := 10:
	set(val):
		life = val
		$CanvasLayer/HPProgressBar.value = life
@onready var aniPlayer : AnimationPlayer = $AnimationPlayer
@onready var spritePlayer : Sprite2D = $Sprite2D
@onready var frutaLabel : Label = $CanvasLayer/HBoxContainer/FrutasLabel
@onready var raycastdmg := $RayCastDamage
@onready var particlePlayer : CPUParticles2D = $CPUParticles2D
@onready var menuButton : MenuButton = $CanvasLayer/MenuButton
@onready var quitPopup := menuButton.get_popup()
@onready var lightPlayer : PointLight2D = $PointLight2D

enum estados {NORMAL, HURT, PAUSE}
var estadoActual = estados.NORMAL

enum STATE {IDLE, RUN, INAIR, FALL, MOVINGAIR, MOVINGFALL}
var state = STATE.IDLE

func _ready() -> void:
	$CanvasLayer/HPProgressBar.value = life
	lightPlayer.enabled = false
	PruebaAuto.player = self
	particlePlayer.emitting = false
	quitPopup.id_pressed.connect(quitSettings)

func _physics_process(delta: float) -> void:
	if estadoActual == estados.NORMAL:
		NormalProces(delta)
	

func NormalProces(delta):
	match state:
		STATE.IDLE:
			velocity.x = 0
			aniPlayer.play("idle")
			
			if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
				state = STATE.RUN
			elif Input.is_action_just_pressed("ui_up") and is_on_floor():
				state = STATE.INAIR
			elif !is_on_floor():
				state = STATE.FALL
		STATE.RUN:
			direction = Input.get_axis("ui_left", "ui_right")
			VelocityInX(delta)
			aniPlayer.play("walk")
			SpriteRotation()
			
			if Input.is_action_just_pressed("ui_up") and is_on_floor():
				state = STATE.INAIR
			elif  !Input.is_action_pressed("ui_left") and !Input.is_action_pressed("ui_right"):
				state = STATE.IDLE
			elif !is_on_floor():
				state = STATE.FALL
		STATE.INAIR:
			numJumps = 1
			JumpImpulse()
			
			if !is_on_floor() and Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
				state = STATE.MOVINGAIR
			if !is_on_floor(): 
				numJumps = 0
				state = STATE.FALL
			if Input.is_action_just_pressed("ui_up") and numJumps == 1:
				JumpImpulse()
		STATE.MOVINGAIR:
			direction = Input.get_axis("ui_left", "ui_right")
			VelocityInX(delta)
			velocity.y += gravity
			SpriteRotation()
			
			if !Input.is_action_pressed("ui_left") and !Input.is_action_pressed("ui_right"):
				state = STATE.INAIR
			if !is_on_floor(): state = STATE.FALL
		STATE.FALL:
			velocity.y += gravity
			particlePlayer.emitting = false
			
			if !is_on_floor() and Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
				state = STATE.MOVINGFALL
			if is_on_floor():
				numJumps = 0
				state =STATE.IDLE
		STATE.MOVINGFALL:
			direction = Input.get_axis("ui_left", "ui_right")
			VelocityInX(delta) 
			velocity.y += gravity
			SpriteRotation()
			
			if !Input.is_action_pressed("ui_left") and !Input.is_action_pressed("ui_right"):
				state = STATE.FALL
			if is_on_floor(): 
				numJumps = 0
				state =STATE.IDLE
	move_and_slide()

func SpriteRotation(): spritePlayer.flip_h = direction < 0 if direction != 0 else spritePlayer.flip_h

func VelocityInX(delta): velocity.x = direction * speed * delta

func JumpImpulse():
	velocity.y -= jumpForce
	aniPlayer.play("jump")
	particlePlayer.emitting = true
	$AudioStreamPlayerJump.play()

func _process(delta: float) -> void:
	for ray in raycastdmg.get_children():
		if ray.is_colliding():
			var colision = ray.get_collider()
			if colision.is_in_group("enemigo"):
				if colision.has_method("takeDmg"):
					colision.takeDmg(damage)

func actualizaInterfrazFrutas(): frutaLabel.text = str(PruebaAuto.fruit)

func TakeDamage(dmg):
	if estadoActual != estados.HURT:
		life -= dmg
		aniPlayer.play("hurt")
		$AudioStreamPlayerHurt.play()
		estadoActual = estados.HURT
		if life <= 0:
			Dead()

func Dead(): get_tree().reload_current_scene()

func quitSettings(id):
	match (id):
		0:
			get_tree().quit()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "hurt":
		estadoActual = estados.NORMAL
