extends Node2D

@onready var andres: CharacterBody2D = $Andres
@onready var camera_2d: Camera2D = $Andres/Camera2D
@onready var musicaFondo: AudioStreamPlayer = $MusicaDeFondo

func _ready() -> void:
	musicaFondo.play()
	camera_2d.limit_bottom = 303
	camera_2d.limit_right = 2889

func _physics_process(delta: float) -> void:
	if global.skipdialogue:
		consultorio1()
		global.skipdialogue = false

func _on_dialogo_1_body_entered(body: Node2D) -> void:
	body = andres
	print("deberia salir aqui el dialogo")
	DialogueManager.show_dialogue_balloon(load("res://Dialogos/PasilloRecuerdos/Pasillo0.dialogue"), "PasilloRecuerdos1")
	$Dialogo1.queue_free()

func _on_dialogo_2_body_entered(body: Node2D) -> void:
	body = andres
	DialogueManager.show_dialogue_balloon(load("res://Dialogos/PasilloRecuerdos/Pasillo0.dialogue"), "PasilloRecuerdos2")
	$Dialogo2.queue_free()

func _on_dialogo_3_body_entered(body: Node2D) -> void:
	body = andres
	DialogueManager.show_dialogue_balloon(load("res://Dialogos/PasilloRecuerdos/Pasillo0.dialogue"), "PasilloRecuerdos3")
	$Dialogo3.queue_free()
	
func consultorio1():
	get_tree().change_scene_to_file("res://Escenarios/Consultas/Consulta1.tscn")
	
