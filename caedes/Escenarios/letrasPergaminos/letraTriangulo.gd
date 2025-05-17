extends Node2D
var interactuarClick = false
@onready var letraGrande: Sprite2D = $LetraTrianguloGrande
@onready var letraPequeño: Sprite2D = $LetraTriangulo4
var Andres = null

func _physics_process(delta: float) -> void:
	if interactuarClick and Input.is_action_pressed("attack"):
		letraGrande.visible = true
		letraPequeño.visible = false
		letraGrande.z_index = 1
	else:
		letraGrande.visible = false
		letraPequeño.visible = true


func _on_area_2d_body_entered(body : Node2D) -> void:
	if body.is_in_group("andres"):
		Andres = body
		interactuarClick = true
		

func _on_area_2d_body_exited(body : Node2D) -> void:
	if body.is_in_group("andres"):
		Andres = body
		interactuarClick = false
		Andres.visible = true
