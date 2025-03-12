extends CharacterBody2D

func _ready() -> void:
	pass
	
func _physics_process(delta):
	
	velocity = Vector2()
	var speed:int = 200
		
	if Input.is_action_pressed("right"):
		velocity.x = speed
		$AnimatedSprite2D.play("walk")
		move_and_slide()
	elif Input.is_action_pressed("left"):
		velocity.x = -speed
		$AnimatedSprite2D.play("walkleft")
		move_and_slide()
	elif Input.is_action_pressed("up"):
		velocity.y = -speed
		$AnimatedSprite2D.play("walk")
		move_and_slide()
	elif Input.is_action_pressed("down"):
		velocity.y = speed
		$AnimatedSprite2D.play("walkleft")
		move_and_slide()
	elif Input.is_action_pressed("up") and Input.is_action_pressed("right"):
		velocity.y = -speed
		velocity.x = speed
		$AnimatedSprite2D.play("walk")
		move_and_slide()
	elif Input.is_action_pressed("up") and Input.is_action_pressed("left"):
		velocity.y = -speed
		velocity.x = -speed
		$AnimatedSprite2D.play("walkleft")
		move_and_slide()
	elif Input.is_action_pressed("down") and Input.is_action_pressed("right"):
		velocity.y = speed
		velocity.x = speed
		$AnimatedSprite2D.play("walk")
		move_and_slide()
	elif Input.is_action_pressed("down") and Input.is_action_pressed("left"):
		velocity.y = speed
		velocity.x = -speed
		$AnimatedSprite2D.play("walkleft")
		move_and_slide()
	else:
		$AnimatedSprite2D.play("static")
		velocity.y = 0
		
