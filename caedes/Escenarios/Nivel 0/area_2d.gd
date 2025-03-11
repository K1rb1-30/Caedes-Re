extends Area2D


func _on_body_entered(body: Node2D) -> void:
	print("Me entro")
	DialogueManager.show_example_dialogue_balloon(load("res://Dialogos/Level0/Tutorial.dialogue"), "tutocat")
	
