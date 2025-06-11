extends State


func StatePhysicsProcess(delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	
	owner.velocity.x = direction * owner.speed
	owner.move_and_slide()
