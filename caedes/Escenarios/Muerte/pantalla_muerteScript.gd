extends Control

@onready var Reintentar: Button = $CanvasLayer/Reintentar
@onready var botonReintenar: Sprite2D = $CanvasLayer/BotonReintenar
@onready var botonSalir: Sprite2D = $CanvasLayer/BotonSalir
@onready var Salir: Button = $CanvasLayer/Salir
@onready var SonidoVHS: AudioStreamPlayer2D = $CanvasLayer/AudioStreamPlayer2D
@onready var Video:VideoStreamPlayer = $CanvasLayer/VideoStreamPlayer
@onready var fondo: Sprite2D = $CanvasLayer/Fondo



func _ready() -> void:
	Reintentar.visible = false #Poner que el boton sea invisible
	botonReintenar.visible = false
	Salir.visible = false
	fondo.visible = false
	botonSalir.visible = false
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED # Permitir procesamientos cuando el juego esté en pausa
	Video.play()
	
	
func _on_video_stream_player_finished() -> void:
	Reintentar.visible = true #Poner que el boton sea visible
	Salir.visible = true
	botonSalir.visible = true
	fondo.visible = true
	botonReintenar.visible = true
	SonidoVHS.play()
	

func mostrar():
	get_tree().paused = true  # Pausar el juego
	set_process(true)  # Asegura que el nodo de la escena (la UI) procese frames
	
	# Desactivar la pausa en el VideoStreamPlayer para que siga reproduciéndose
	Video.set_process(true)  # Hacer que el video siga reproduciéndose mientras el juego está en pausa
	Video.set_process_input(true)  # Asegurarse de que el video siga recibiendo input si es necesario

func _on_button_pressed() -> void: #Boton de reiniciar
	get_tree().paused = false
	get_tree().reload_current_scene() #Reinicia la Escena
	global.health = 100
	global.puedeMoverse = true


func _on_salir_pressed() -> void:
	get_tree().quit()
