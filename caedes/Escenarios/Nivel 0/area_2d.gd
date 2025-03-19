extends Area2D
@onready var andres: CharacterBody2D = $"../Andres"


func _on_timer_dialogo_timeout() -> void:
	DialogueManager.show_example_dialogue_balloon(load("res://Dialogos/Level0/Tutorial.dialogue"), "tutocat")
