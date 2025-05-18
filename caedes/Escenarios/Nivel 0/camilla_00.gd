extends Node2D


@export var enemigo_escena: PackedScene = preload("res://assets/enemies/MINIONS/enemy_minion.tscn")
@export var cantidad = 5

@onready var andres: CharacterBody2D = $Andres
@onready var linternaLuz: PointLight2D = $Andres/linternaLuz

@onready var musica: AudioStreamPlayer = $Musica

@onready var puertas: TileMapLayer = $Suelo/Puertas
@onready var puerta_colision: StaticBody2D = $puertaColision

@onready var camera_2d: Camera2D = $Andres/Camera2D
@onready var presiona_f: Label = $Andres/PresionaF

@onready var letrakGrande: Sprite2D = $LetraKGrande
@onready var letrak: Sprite2D = $LetraK

@onready var letrah3: Sprite2D = $LetraH3Grande

@onready var letraAgrande: Sprite2D = $LetraAGrande
var interactuarA = false

@onready var investigar_F: Label = $Andres/InvestigarF
@onready var letrah5grande: Sprite2D = $LetraH5Grande
@onready var letrah5: Sprite2D = $LetraH5
var interactuarF = false

@onready var letrae: Sprite2D = $LetraE
@onready var letraEgrande: Sprite2D = $LetraEGrande
var interactuarLinterna = false


@onready var keypad: Control = $Keypad
var puede_interactuar = false

var posicion_enemigos = [
	Vector2(831,511),
	Vector2(661, 688),
	Vector2(904, 690),
	Vector2(586, 530),
	Vector2(688, 587)
]

func _ready() -> void:
	keypad.visible = false
	global.puedeMoverse = false
	playAnimationCandelario("candelario")
	playAnimationAntorcha("antorcha")
	DialogueManager.show_dialogue_balloon(load("res://Dialogos/Level0/Tutorial.dialogue"), "tutocat")
	for posicion in posicion_enemigos:
		spawn_enemigo(posicion)
		
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("presionarE"): 
		global.puedeMoverse = true
		#andres.position = Vector2(128, 124)
	if puede_interactuar and global.labelOK == true and Input.is_action_just_pressed("interactuarF"):
		await get_tree().process_frame
		await get_tree().create_timer(0.5).timeout
		trans.cambiarEscena("res://Escenarios/PasilloRecuerdos/pasilloRecuerdos.tscn")
		musica.stop()
	if global.labelOK == true:
		keypad.visible = false

	if interactuarA and Input.is_action_pressed("attack"):
		letraAgrande.visible = true
	else:
		letraAgrande.visible = false
	if interactuarF and Input.is_action_pressed("interactuarF"):
		letrah5grande.visible = true
	else:
		letrah5grande.visible = false
	
	if interactuarLinterna and Input.is_action_pressed("interactuarF"):
		linternaLuz.visible = true

func spawn_enemigo(posicion: Vector2):
	var enemigo = enemigo_escena.instantiate()
	enemigo.position = posicion
	add_child(enemigo)


func playAnimationCandelario(candelario: String):
	var spritesCandelario = get_tree().get_nodes_in_group("anim_candelario")
	for spriteCan in spritesCandelario:
		if spriteCan is AnimatedSprite2D:
			spriteCan.play(candelario)
func playAnimationAntorcha(antorcha: String):
	var spritesAntorcha = get_tree().get_nodes_in_group("anim_antorcha")
	for spriteAn in spritesAntorcha:
		if spriteAn is AnimatedSprite2D:
			spriteAn.play(antorcha)
	


func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	body = $Andres
	puertas.visible = true
	puerta_colision.collision_mask = 1
	puerta_colision.collision_layer = 1

func _on_area_presionar_body_entered(body: Node2D) -> void:
	body = $Andres
	presiona_f.visible = true
	puede_interactuar = true
	keypad.visible = true
	

func _on_area_presionar_body_exited(body: Node2D) -> void:
	body = $Andres
	presiona_f.visible = false
	puede_interactuar = false
	keypad.visible = false


#FUNCIONES PARA LOS PERGAMINOS DE LAS LETRAS

func _on_letrak_body_entered(body: Node2D) -> void:
	body = $Andres
	letrakGrande.visible = true
	letrak.visible = true


func _on_letrak_body_exited(body: Node2D) -> void:
	body = $Andres
	letrakGrande.visible = false
	maspergaminos()
	letrak.visible = true


func _on_letra_a_body_entered(body: Node2D) -> void:
	body = $Andres
	interactuarA = true


func _on_letra_a_body_exited(body: Node2D) -> void:
	body = $Andres
	maspergaminos()
	interactuarA = false


func _on_letrah_5_body_entered(body: Node2D) -> void:
	body = $Andres
	investigar_F.visible = true
	interactuarF = true


func _on_letrah_5_body_exited(body: Node2D) -> void:
	body = $Andres
	investigar_F.visible = false
	maspergaminos()
	interactuarF = false


func _on_letra_e_body_entered(body: Node2D) -> void:
	body = $Andres
	letraEgrande.visible = true


func _on_letra_e_body_exited(body: Node2D) -> void:
	body = $Andres
	maspergaminos()
	letraEgrande.visible = false


func _on_linterna_area_body_entered(body: Node2D) -> void:
	interactuarLinterna = true


func _on_linterna_area_body_exited(body: Node2D) -> void:
	interactuarLinterna = false




#Esto es para pausar el personaje cuando se requiera
func pausarPersonaje():
	global.puedeMoverse = false

#Esto es para reanudarlo cuando se pueda tambn se puede llamra la funcion en el dialogo para hacer que cuando acabe el dialogo el personaje vuelva a poder moverse
func reanudarPersonaje():
	global.puedeMoverse = true

#AREAS CON LOS DIALOGOS

func _on_dialogo_donde_estamos_body_entered(body: Node2D) -> void:
	body = $Andres
	pausarPersonaje()
	DialogueManager.show_dialogue_balloon(load("res://Dialogos/Level0/Tutorial.dialogue"), "tutocat2")
	$DialogoDondeEstamos.queue_free()


func _on_dialogo_pergamino_body_entered(body: Node2D) -> void:
	body = $Andres
	pausarPersonaje()
	DialogueManager.show_dialogue_balloon(load("res://Dialogos/Level0/Tutorial.dialogue"), "pergamino")
	$DialogoPergamino.queue_free()

func mostrar_letraH3():
	letrah3.visible = true
	ocultar_letraH3()
	
func ocultar_letraH3():
	await get_tree().create_timer(4).timeout
	letrah3.visible = false

func maspergaminos():
	if global.segundopergamino:
		pausarPersonaje()
		DialogueManager.show_dialogue_balloon(load("res://Dialogos/Level0/Tutorial.dialogue"), "maspergaminos")
		global.segundopergamino = false
	

func _on_dialogo_tuto_enemigo_body_entered(body: Node2D) -> void:
	body = $Andres
	pausarPersonaje()
	DialogueManager.show_dialogue_balloon(load("res://Dialogos/Level0/Tutorial.dialogue"), "tutocombate")
	$DialogoTutoEnemigo.queue_free()
