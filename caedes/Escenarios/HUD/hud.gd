extends Control
class_name HUD
@onready var sprite: AnimatedSprite2D = $HBoxContainer/AnimatedSprite2D

@export var NumeroVida : Label
@export var NumeroEstado : Label

func update_vida(number : int):
	NumeroVida.text = "x" + str(number)
	
func update_paniquea(number : int):
	NumeroEstado.text = "Estas Paniqueando"

func _ready() -> void:
	sprite.play("Default")
