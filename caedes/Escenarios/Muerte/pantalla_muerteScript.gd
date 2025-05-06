extends Control

@onready var Continuar: Button = $CanvasLayer/Button
@onready var Salir: Button = $CanvasLayer/Salir
@onready var SonidoVHS: AudioStreamPlayer2D = $CanvasLayer/AudioStreamPlayer2D
@onready var Video:VideoStreamPlayer = $CanvasLayer/VideoStreamPlayer

func _ready() -> void:
	Continuar.visible = false #Poner que el boton sea invisible
	Salir.visible = false
	hide()  # Ocultar al inicio
	var pause_mode = Node.PROCESS_MODE_WHEN_PAUSED # Permitir interacción cuando el juego esté en pausa
	Video.play()
	
func _on_video_stream_player_finished() -> void:
	Continuar.visible = true #Poner que el boton sea invisible
	Salir.visible = true
	SonidoVHS.play()

func mostrar():
	show()
	get_tree().paused = true
	set_process_input(true)  # Asegura que el input sea procesado
	set_process(true)  # Asegura que el nodo pueda procesar los frames

"""
En mi vida fuistes turista
Tú solo vistes lo mejor de mí
Y no lo que yo sufría
Te fuiste sin saber el porqué
El porqué de mis herida'
Y no te tocaba a ti curarla'
Vinistes a pasarla bien
Y la pasamos bien
Una foto bonita
Un atardecer hermoso
Una bailaíta
Tu cadenita de oro
Estuvimos tan cerquita
Mirándono a los ojo'
Dime si vistes la pena
De mi corazón roto
"""

func _on_button_pressed() -> void: #Boton de reiniciar
	get_tree().paused = false
	get_tree().reload_current_scene() #Reinicia la Escena
