extends CharacterBody2D

var velocidad = 300
var accel = 7

@onready var nav: NavigationAgent2D = $NavigationAgent2D

func _physics_process(delta):
	var direccion = Vector3()
	
	nav.target_position = get_global_mouse_position()
	
	direccion = nav.get_next_path_position() - global_position
	direccion = direccion.normalized()
	
	velocity = velocity.lerp(direccion * velocidad, accel * delta)
	
	move_and_slide()
