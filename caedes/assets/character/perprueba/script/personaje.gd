extends CharacterBody2D

func _ready() -> void:
	$AnimatedSprite2D.play("static")
	
func _physics_process(delta):
	var direccion = Input.get_vector("left", "right", "up", "down")
	$AnimatedSprite2D.play("walk")
	velocity = direccion * 150
	move_and_slide()
