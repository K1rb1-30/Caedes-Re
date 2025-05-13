extends Control

var cambiarEscena = preload("res://Escenarios/Nivel 0/Camilla00.tscn")
<<<<<<< Updated upstream
@onready var volumen_num: Label = $VBoxContainer2/VolumenNum
@onready var settings: VBoxContainer = $VBoxContainer2
@onready var menu: HBoxContainer = $VBoxContainer
=======
@onready var settings: MenuBar = $MenuOpciones
@onready var menu: MenuBar = $Menu
@onready var volumenMusica: HSlider = $MenuOpciones/VMusica
@onready var vefectos: HSlider = $MenuOpciones/VEfectos
@onready var audioMenu: AudioStreamPlayer = $AudioMenu

var busIndexM : float
var busIndexE : float

func _ready() -> void:
	busIndexM = AudioServer.get_bus_index("Musica")
	
	volumenMusica.value = db_to_linear(AudioServer.get_bus_volume_db(busIndexM))
	
	busIndexE = AudioServer.get_bus_index("Efectos de sonido")
	
	vefectos.value = db_to_linear(AudioServer.get_bus_volume_db(busIndexE))
func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(busIndexM, linear_to_db(value))

func _on_v_efectos_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(busIndexE, linear_to_db(value))
>>>>>>> Stashed changes


func _on_play_pressed() -> void:
	get_tree().change_scene_to_packed(cambiarEscena)


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_options_pressed() -> void:
	settings.visible = true
	menu.visible = false


func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, value)
	volumen_num.text = str(value)

func _on_check_box_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(0,toggled_on)

func _on_resolucion_item_selected(index: int) -> void:
	print("Índice seleccionado: ", index)
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	match index:
		0:
			DisplayServer.window_set_size(Vector2i(1920,1080))
			print("Cambiando a 1920x1080")
		1:
			DisplayServer.window_set_size(Vector2i(1660,990))
		2:
			DisplayServer.window_set_size(Vector2i(1280,720))


func _on_save_pressed() -> void:
	settings.visible = false
	menu.visible = true
