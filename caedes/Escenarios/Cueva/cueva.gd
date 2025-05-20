extends Node2D

@onready var camera_2d: Camera2D = $Andres/Camera2D
@onready var presiona_f: Label = $Andres/PresionaF
@onready var advertencia: Label = $Andres/Advertencia
@onready var explotarF: Label = $Andres/PresionarFExplotar
@onready var linternaLuz: PointLight2D = $Andres/linternaLuz

@onready var labelExplosion: Label = $Andres/timer
var puede_interactuar = false
var explotar = false
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer
@onready var timerExplosion: Timer = $TimerExplosion
var yaExploto = true
@onready var cambiarEscena = preload("res://Escenarios/Consultas/Consulta2.tscn")
var andres = null
var dentroDelAreaExplosion = false
@onready var explosionLayer: TileMapLayer = $Suelo/Explosion
@onready var sinExplotar: StaticBody2D = $ColisionSinExplotar


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
	andres = get_node("Andres")
	if global.tieneLinterna:
		linternaLuz.visible = true
	pausarPersonaje()
	DialogueManager.show_dialogue_balloon(load("res://Dialogos/Cueva/Cueva.dialogue"), "DespertarCueva")
	

#Esto es para pausar el personaje cuando se requiera
func pausarPersonaje():
	global.puedeMoverse = false

#Esto es para reanudarlo cuando se pueda tambn se puede llamra la funcion en el dialogo para hacer que cuando acabe el dialogo el personaje vuelva a poder moverse
func reanudarPersonaje():
	global.puedeMoverse = true

func _physics_process(delta: float) -> void:
	if puede_interactuar and Input.is_action_pressed("interactuarF"):
		camera_2d.start_shake(10, 8)
		audio.play()
		global.puedeMoverse = false
		$TimerFin.start()
		presiona_f.visible = false
		
		

func _process(delta) -> void:
	if explotar and yaExploto and Input.is_action_pressed("interactuarF"): # Esta en el area de la dinamita, solo tiene una explosion, Input con la F para explotar 
		yaExploto = false # Ya no puede explotar
		timerExplosion.start()
		global.mecheroRecogido = false
		$cronometroExplosion.play()
		labelExplosion.visible = true
		explotarF.visible = false

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
	

func _on_area_2d_body_exited(body: Node2D) -> void:
	body = $Andres
	presiona_f.visible = false
	puede_interactuar = false


func _on_dinamita_area_body_entered(body: Node2D) -> void:
	body = $Andres
	dentroDelAreaExplosion = true

func _on_dinamita_area_body_exited(body: Node2D) -> void:
	body = $Andres
	dentroDelAreaExplosion = false


func _on_dinamita_explotar_body_entered(body: Node2D) -> void:
	body = $Andres
	if global.mecheroRecogido:
		explotarF.visible = true # Label diciendo presiona F para explotar
		explotar = true # Esta en el area y puede explotar
	else:
		advertencia.visible = true # Label diciendo tienes que conseguir un mechero

func _on_dinamita_explotar_body_exited(body: Node2D) -> void:
	body = $Andres
	if global.mecheroRecogido:
		explotarF.visible = false
	else:
		advertencia.visible = false


func _on_timer_explosion_timeout() -> void:
	$FinColor.visible = true
	global.puedeMoverse = false
	$Andres.z_index = -1
	$explosion.play()
	$Dinamita.visible = false
	$dinamitaExplotar.collision_mask = 0
	sinExplotar.collision_layer = 0
	sinExplotar.collision_mask = 0
	
	
	


func _on_explosion_finished() -> void:
	if dentroDelAreaExplosion:
		andres.health = 0
	else:
		$FinColor.visible = false
		$Andres.z_index = 1
		explosionLayer.visible = false
		global.puedeMoverse = true
		explotarF.visible = false
		labelExplosion.visible = false


func _on_selva_finished() -> void:
	get_tree().change_scene_to_packed(cambiarEscena)
