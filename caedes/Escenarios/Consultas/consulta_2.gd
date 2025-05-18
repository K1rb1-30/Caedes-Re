extends Node2D

@onready var beep: AudioStreamPlayer = $beep
@onready var sonidoReloj: AudioStreamPlayer = $"Sonido del reloj"


func _ready():
	beep.play()
	await get_tree().create_timer(2).timeout
	sonidoReloj.play()
	start_fade_to_white()
	await get_tree().create_timer(1).timeout
	DialogueManager.show_dialogue_balloon(load("res://Dialogos/Psicologo/InicioVisita0.dialogue"), "consulta2")

func start_fade_to_white():
	var rect = $CanvasLayer/ColorRect
	rect.color = Color(1, 1, 1, 0) # blanco transparente
	rect.visible = true
	var tween = create_tween()
	tween.tween_property(rect, "color:a", 1.0, 2.0) # fundido a blanco en 2 segundos
	tween.connect("finished", Callable(self, "start_scene"))

func set_emotion_color(color: Color):
	var tween = create_tween()
	tween.tween_property($CanvasModulate, "color", color, 1.5)

func end_scene():
	var rect = $CanvasLayer/ColorRect
	var tween = create_tween()
	tween.tween_property(rect, "color:b", 1.0, 3.0) # fundido a negro
	await tween.finished
	get_tree().change_scene_to_file("res://Escenarios/Creditos/creditos.tscn") #Cambiar esto
	
func _on_dialogue_finished():
	await get_tree().create_timer(1).timeout
	end_scene()
