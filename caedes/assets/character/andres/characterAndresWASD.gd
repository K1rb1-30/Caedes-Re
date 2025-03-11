extends CharacterBody2D

func _physics_process(delta):
	var direccion = Input.get_vector("left", "right", "up", "down")
	velocity = direccion * 200
	move_and_slide()
