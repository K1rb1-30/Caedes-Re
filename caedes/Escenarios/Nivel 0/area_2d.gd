extends Area2D
@onready var andres: CharacterBody2D = $JugadorPRUEBA

var ya_aparecio = false  # Variable para controlar si ya ha aparecido

func _on_body_entered(body: Node2D) -> void:
		andres = body
		DialogueManager.show_example_dialogue_balloon(load("res://Dialogos/Level0/Tutorial.dialogue"), "tutocat")
		self.queue_free()
