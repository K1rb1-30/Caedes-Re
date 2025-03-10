extends Node2D

@onready var imagenCamillaSin = $CamillaSinPersonaje
@onready var imagenCamilla = $Camilla
@onready var Personaje = $AndresAD
@onready var pulsaE: Label = $"Pulsa E"

func _process(delta):
	if Input.is_action_just_pressed("accionE"):
		camilla()
		
func camilla():
	imagenCamilla.visible = false
	imagenCamillaSin.visible = true
	Personaje.visible = true
	pulsaE.visible = false
