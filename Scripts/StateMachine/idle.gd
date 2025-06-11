extends State


func StateEnter(msg := {}):
	owner.velocity = Vector2.ZERO

func StateProcess(delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction != Vector2.ZERO:
		stateMachine.TransitionTo("Moving")
