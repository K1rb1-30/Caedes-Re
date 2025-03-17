extends Area2D


var ya_aparecio = false  # Variable para controlar si ya ha aparecido

func _on_body_entered(body: Node2D) -> void:
	if !ya_aparecio :
		# Primer evento: habilitar y mostrar el CollisionShape2D
		$CollisionShape2D.show()
		DialogueManager.show_example_dialogue_balloon(load("res://Dialogos/Level0/Tutorial.dialogue"), "tutocat")
		$CollisionShape2D.disabled = false
		ya_aparecio = true  # Marca como que ya ha aparecido
	else:
		# Después de que ha aparecido, lo ocultamos y deshabilitamos
		$CollisionShape2D.hide()
		$CollisionShape2D.disabled = true
