extends Control

const password = "ΚΑΗΔΗΣ"

@onready var label = $VBoxContainer/MarginContainer/Label


func key_press(digit):
	if len(label.text) < 6:
		label.text += str(digit)


func _on_button_1_pressed() -> void:
	key_press("Γ")


func _on_button_2_pressed() -> void:
	key_press("Δ")


func _on_button_3_pressed() -> void:
	key_press("Α")


func _on_button_4_pressed() -> void:
	key_press("Κ")


func _on_button_5_pressed() -> void:
	key_press("Σ")


func _on_button_6_pressed() -> void:
	key_press("Η")


func _on_button_7_pressed() -> void:
	key_press("π")


func _on_button_8_pressed() -> void:
	key_press("C")
	label.text = ""


func _on_button_9_pressed() -> void:
	key_press("")
	if label.text == password:
		print("Contraseña correcta")
		global.labelOK = true
	else:
		print("Contraseña incorrecta")


func _on_cerrar_pad_pressed() -> void:
	$VBoxContainer.visible = false
	global.cerrarPad = true
