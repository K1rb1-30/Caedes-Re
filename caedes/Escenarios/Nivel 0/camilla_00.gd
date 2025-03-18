extends Node2D


func _on_timer_dialogo_timeout() -> void:
	DialogueManager.show_example_dialogue_balloon(load("res://Dialogos/Level0/Tutorial.dialogue"), "tutocat")
