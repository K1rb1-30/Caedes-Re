extends Area2D

@export var ArchivoDialogo : String
@export var DialogoRenderizar : String
@onready var andres: CharacterBody2D = $"../Andres"

func _on_body_entered(body: Node2D) -> void:
		andres = body
		DialogueManager.show_example_dialogue_balloon(load(ArchivoDialogo), DialogoRenderizar)
		self.queue_free()
