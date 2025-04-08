extends Control

var cambiarEscena = preload("res://Escenarios/Nivel 0/Camilla00.tscn")
@onready var volumen_num: Label = $VBoxContainer2/VolumenNum
@onready var settings: VBoxContainer = $VBoxContainer2
@onready var menu: HBoxContainer = $VBoxContainer


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
	match index:
		0:
			DisplayServer.window_set_size(Vector2i(1920,1080))
		1:
			DisplayServer.window_set_size(Vector2i(1660,990))
		2:
			DisplayServer.window_set_size(Vector2i(1280,720))


func _on_save_pressed() -> void:
	settings.visible = false
	menu.visible = true
	
