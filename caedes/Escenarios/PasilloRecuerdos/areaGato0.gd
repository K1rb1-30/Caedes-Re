extends Area2D

@onready var andres: CharacterBody2D = $Jugador

func _on_body_entered(body: Node2D) -> void:
		andres = body
		DialogueManager.show_example_dialogue_balloon(load("res://Dialogos/PasilloRecuerdos/Pasillo0.dialogue"), "start")
		self.queue_free()
