extends Control

@onready var volumenMusica: HSlider = $MenuOpciones/VMusica
@onready var vefectos: HSlider = $MenuOpciones/VEfectos

var busIndexM : int
var busIndexE : int

func _ready() -> void:
	busIndexM = AudioServer.get_bus_index("Musica")
	
	volumenMusica.value = db_to_linear(AudioServer.get_bus_volume_db(busIndexM))
	
	busIndexE = AudioServer.get_bus_index("Efectos de sonido")
	
	vefectos.value = db_to_linear(AudioServer.get_bus_volume_db(busIndexE))

func _on_v_efectos_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(busIndexE, linear_to_db(value))

func _on_v_musica_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(busIndexM, linear_to_db(value))

func _on_save_pressed() -> void:
	$".".visible = false

func _on_salir_pressed() -> void:
	get_tree().quit()

func _on_check_box_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(0,toggled_on)
