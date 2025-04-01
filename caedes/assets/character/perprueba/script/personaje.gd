extends CharacterBody2D

func _ready() -> void:
	pass
	
func _physics_process(delta):
	
	velocity = Vector2.ZERO
	var speed:int = 100
	
	if Input.is_action_pressed("right"):
		velocity += Vector2(1, 0)
		$AnimatedSprite2D.play("walk")
		
	elif Input.is_action_pressed("left"):
		velocity += Vector2(-1, 0)
		$AnimatedSprite2D.play("walkleft")
		
	if Input.is_action_pressed("up"):
		velocity += Vector2(0, -1)
		$AnimatedSprite2D.play("walk")
	elif Input.is_action_pressed("down"):
		velocity += Vector2(0, 1)
		$AnimatedSprite2D.play("walkleft")
	if velocity == Vector2(0, 0) :
		$AnimatedSprite2D.play("static")
		
	velocity = velocity.normalized() * speed
		
	move_and_slide()
	
	
		
