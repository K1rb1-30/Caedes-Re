extends Node2D
var interactuarClick = false
@onready var letraGrande: Sprite2D = $LetraTrianguloGrande
const CHARACTER_ANDRES_WASD = preload("res://assets/character/andres/characterAndresWASD.tscn")

func _physics_process(delta: float) -> void:
	if interactuarClick and Input.is_action_pressed("attack"):
		letraGrande.visible = true
	else:
		letraGrande.visible = false


func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	letraGrande.visible = true

func _on_area_2d_body_exited(body: CharacterBody2D) -> void:
	letraGrande.visible = false
