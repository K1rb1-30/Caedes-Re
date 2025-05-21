extends Control

var cambiarEscena = preload("res://Escenarios/Consultas/Consulta0.tscn")
@onready var settings: MenuBar = $MenuOpciones
@onready var menu: MenuBar = $Menu
@onready var volumenMusica: HSlider = $MenuOpciones/VMusica
@onready var vefectos: HSlider = $MenuOpciones/VEfectos
@onready var audioMenu: AudioStreamPlayer = $AudioMenu

var busIndexM : int
var busIndexE : int

func _ready() -> void:
	volumenMusica.value = 2
	vefectos.value = 2
	busIndexM = AudioServer.get_bus_index("Musica")
	
	volumenMusica.value = db_to_linear(AudioServer.get_bus_volume_db(busIndexM))
	
	busIndexE = AudioServer.get_bus_index("Efectos de sonido")
	
	vefectos.value = db_to_linear(AudioServer.get_bus_volume_db(busIndexE))
func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(busIndexM, linear_to_db(value))

func _on_v_efectos_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(busIndexE, linear_to_db(value))


func _on_play_pressed() -> void:
	get_tree().change_scene_to_packed(cambiarEscena)

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_options_pressed() -> void:
	settings.visible = true
	menu.visible = false
	$Opciones.visible = true

func _on_check_box_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(0,toggled_on)

func _on_save_pressed() -> void:
	settings.visible = false
	menu.visible = true
	$Opciones.visible = false

func _on_interrogante_pressed() -> void:
	OS.shell_open("https://caedes-landing.vercel.app/")
