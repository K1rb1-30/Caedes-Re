extends Node2D
@onready var camera_2d: Camera2D = $Andres/Camera2D
@onready var presiona_f: Label = $Andres/PresionaF
@onready var advertencia: Label = $Andres/Advertencia
@onready var explotarF: Label = $Andres/PresionarFExplotar
@onready var labelExplosion: Label = $Andres/timer
var puede_interactuar = false
var explotar = false
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer
@onready var timerExplosion: Timer = $TimerExplosion
var yaExploto = true
@onready var cambiarEscena = preload("res://Escenarios/Creditos/creditos.tscn")

"""

Yo soy del sur

Andalucía es mi tierra
Yo soy del sur
Yo soy del sur, Andalucía es mi tierra
Soy del sur, soy andaluz
Me gusta el mosto en noviembre y mirar al cielo azul
Y mirar al cielo azul
De aquí fueron mis abuelos
Se formaron mis mayores
Aquí nacieron mis padres
Y nacieron mis amores
"""

func _ready() -> void:
	camera_2d.limit_bottom = 1263
	camera_2d.limit_right = 1328

func _physics_process(delta: float) -> void:
	if puede_interactuar and Input.is_action_pressed("interactuarF"):
		camera_2d.start_shake(10, 8)
		audio.play()
		global.puedeMoverse = false
		$TimerFin.start()
		

func _process(delta) -> void:
	if explotar and yaExploto and Input.is_action_pressed("interactuarF"):
		yaExploto = false
		timerExplosion.start()
		labelExplosion.visible = true
		$cronometroExplosion.play()
	if not timerExplosion.is_stopped() and labelExplosion.visible:
		labelExplosion.text = str("%.1f" % timerExplosion.time_left)	
func _on_timer_fin_timeout() -> void:
	$FinColor.visible = true
	$Andres.z_index = -1
	$TimerSelva.start()
	
func _on_timer_selva_timeout() -> void:
	$Selva.play()

func _on_area_2d_body_entered(body: Node2D) -> void:
	body = $Andres
	presiona_f.visible = true
	puede_interactuar = true
	

@warning_ignore("unused_parameter")
func _on_area_2d_body_exited(body: Node2D) -> void:
	body = $Andres
	presiona_f.visible = false
	puede_interactuar = false


func _on_cambiar_escena_timeout() -> void:
	get_tree().change_scene_to_packed(cambiarEscena)


func _on_dinamita_area_body_entered(body: Node2D) -> void:
	body = $Andres


func _on_dinamita_area_body_exited(body: Node2D) -> void:
	body = $Andres


func _on_dinamita_explotar_body_entered(body: Node2D) -> void:
	body = $Andres
	
	if global.mecheroRecogido:
		explotarF.visible = true
		explotar = true
	else:
		advertencia.visible = true

func _on_dinamita_explotar_body_exited(body: Node2D) -> void:
	body = $Andres
	if global.mecheroRecogido:
		explotarF.visible = false
	else:
		advertencia.visible = false


func _on_timer_explosion_timeout() -> void:
	$FinColor.visible = true
	$Andres.z_index = -1
	$explosion.play()


func _on_explosion_finished() -> void:
	$FinColor.visible = false
	$Andres.z_index = 1
	
