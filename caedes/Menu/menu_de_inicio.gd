extends Control


func _on_play_pressed() -> void:
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_options_pressed() -> void:
<<<<<<< Updated upstream
	pass # Replace with function body.
=======
	settings.visible = true
	menu.visible = false


func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, value)
	volumen_num.text = str(value)

func _on_check_box_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(0,toggled_on)

func _on_save_pressed() -> void:
	settings.visible = false
	menu.visible = true
	
>>>>>>> Stashed changes
