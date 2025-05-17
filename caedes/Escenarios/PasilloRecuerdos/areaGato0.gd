extends Area2D

@export var ArchivoDialogo : String
@export var DialogoRenderizar : String
@onready var andres: CharacterBody2D = $"../Andres"

func _on_body_entered(body: Node2D) -> void:
	print("deberia salir aqui el dialogo")
	andres = body
	DialogueManager.show_dialogue_balloon(load(ArchivoDialogo), DialogoRenderizar)
	self.queue_free()
