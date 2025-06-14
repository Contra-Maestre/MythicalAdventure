extends Node

@onready var player: Player = self.owner


enum STATE {IDLE, RUN, INAIR, FALL}
var state = STATE.IDLE

func _physics_process(delta: float) -> void:
	match state:
		STATE.IDLE:
			player.velocity.x = 0
			player.aniPlayer.play("idle")
			
			if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
				state = STATE.RUN
			elif Input.is_action_just_pressed("ui_up") and player.is_on_floor():
				state = STATE.INAIR
			elif !player.is_on_floor():
				state = STATE.FALL
		STATE.RUN:
			player.direction = Input.get_axis("ui_left", "ui_right")
			player.velocity.x = player.direction * player.speed * delta
			player.aniPlayer.play("walk")
			player.spritePlayer.flip_h = player.direction < 0 if player.direction != 0 else player.spritePlayer.flip_h
			
			if Input.is_action_just_pressed("ui_up") and player.is_on_floor():
				state = STATE.INAIR
			elif  !Input.is_action_pressed("ui_left") and !Input.is_action_pressed("ui_right"):
				state = STATE.IDLE
			elif !player.is_on_floor():
				state = STATE.FALL
		STATE.INAIR:
			player.velocity.y -= player.jumpForce
			player.aniPlayer.play("jump")
			player.particlePlayer.emitting = true
			$"../AudioStreamPlayerJump".play()
			if player.velocity.y > 0: state = STATE.FALL
			
		STATE.FALL:
			player.velocity.y += player.gravity
			player.particlePlayer.emitting = false
			
			if player.is_on_floor(): state =STATE.IDLE
	player.move_and_slide()
