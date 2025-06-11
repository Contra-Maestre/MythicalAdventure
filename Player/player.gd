extends CharacterBody2D
class_name Player

var speed : int = 12000
var direction = 0.0
const  gravity : float = 10.0
var jumpForce : float = 250.0
var damage : int = 1
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

func _ready() -> void:
	$CanvasLayer/HPProgressBar.value = life
	#lightPlayer.enabled = false
	#PruebaAuto.player = self
	#particlePlayer.emitting = false
	#quitPopup.id_pressed.connect(quitSettings)
#
#func _physics_process(delta: float) -> void:
	#if estadoActual == estados.NORMAL:
		#NormalProces(delta)
	#
#
#func NormalProces(delta):
	#direction = Input.get_axis("ui_left", "ui_right")
	#velocity.x = direction * speed * delta
	#
	#if direction != 0:
		#aniPlayer.play("walk")
	#else :
		#aniPlayer.play("idle")
	#
	#spritePlayer.flip_h = direction < 0 if direction != 0 else spritePlayer.flip_h
	#
	#if is_on_floor() and Input.is_action_just_pressed("ui_up"):
		#velocity.y -= jumpForce
		#particlePlayer.emitting = true
		#$AudioStreamPlayerJump.play()
	#
	#if !is_on_floor():
		#velocity.y += gravity
		#particlePlayer.emitting = false
	#move_and_slide()
	#
#
#func _process(delta: float) -> void:
	#for ray in raycastdmg.get_children():
		#if ray.is_colliding():
			#var colision = ray.get_collider()
			#if colision.is_in_group("enemigo"):
				#if colision.has_method("takeDmg"):
					#colision.takeDmg(damage)
#
#func actualizaInterfrazFrutas():
	#frutaLabel.text = str(PruebaAuto.fruit)
#
#func TakeDamage(dmg):
	#if estadoActual != estados.HURT:
		#life -= dmg
		#aniPlayer.play("hurt")
		#$AudioStreamPlayerHurt.play()
		#estadoActual = estados.HURT
		#if life <= 0:
			#Dead()
#
#func Dead():
	#get_tree().reload_current_scene()
#
#
#func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	#if anim_name == "hurt":
		#estadoActual = estados.NORMAL
#
#func quitSettings(id):
	#match (id):
		#0:
			#get_tree().quit()
