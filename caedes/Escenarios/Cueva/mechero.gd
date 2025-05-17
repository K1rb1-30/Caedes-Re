extends Node2D

var interactuarMechero = false
@onready var mechero: Sprite2D = $Mechero
var Andres = null


func _physics_process(delta: float) -> void:
	if interactuarMechero and Input.is_action_just_pressed("interactuarF"):
		global.mecheroRecogido = true
		self.queue_free()

func _on_mechero_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("andres"):
		Andres = body
		interactuarMechero = true
		global.labelMechero = true

func _on_mechero_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("andres"):
		Andres = body
		interactuarMechero = false
		global.labelMechero = false 
