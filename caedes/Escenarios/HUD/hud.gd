extends Control
class_name HUD
@export var NumeroVida : Label
@export var NumeroEstado : Label

func update_vida(number : int):
	NumeroVida.text = "x " + str(number)
	
func update_paniquea(number : int):
	NumeroEstado.text = "Estas Paniqueando"

func _on_focus_entered() -> void:
	$AnimatedSprite2D.play("Default")
