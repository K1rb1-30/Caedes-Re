extends Node2D
@onready var camera_2d: Camera2D = $Andres/Camera2D
@onready var presiona_f: Label = $Andres/PresionaF
var puede_interactuar = false
"""

Yo soy del sur

Andalucía es mi tierra
Yo soy del sur
Yo soy del sur, Andalucía es mi tierra
Soy del sur, soy andaluz
Me gusta el mosto en noviembre y mirar al cielo azul
Y mirar al cielo azul
De aquí fueron mis abuelos
Se formaron mis mayores
Aquí nacieron mis padres
Y nacieron mis amores
"""

func _ready() -> void:
	camera_2d.limit_bottom = 1263.0
	camera_2d.limit_right = 1328.0
	
func _physics_process(delta: float) -> void:
	if puede_interactuar and Input.is_action_pressed("interactuarF"):
		camera_2d.start_shake(1.5, 8.0)

func _on_area_2d_body_entered(body: Node2D) -> void:
	presiona_f.visible = true
	puede_interactuar = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	presiona_f.visible = false
	puede_interactuar = false
