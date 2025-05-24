extends Node2D


@export var enemigo_escena: PackedScene = preload("res://assets/enemies/MINIONS/enemy_minion.tscn")
@export var cantidad = 5

@onready var andres: CharacterBody2D = $Andres
@onready var linternaLuz: PointLight2D = $Andres/linternaLuz

@onready var musica: AudioStreamPlayer = $Musica

@onready var camera_2d: Camera2D = $Andres/Camera2D
@onready var presiona_f: Label = $Andres/PresionaF

@onready var letrakGrande: Sprite2D = $LetraKGrande
@onready var letrak: Sprite2D = $LetraK

@onready var letrah3: Sprite2D = $LetraH3
@onready var letrah3Grande: Sprite2D = $LetraH3Grande


@onready var letraAgrande: Sprite2D = $LetraAGrande
var interactuarA = false

@onready var investigar_E: Label = $Andres/InvestigarE
@onready var letrah5grande: Sprite2D = $LetraH5Grande
@onready var letrah5: Sprite2D = $LetraH5
var interactuarE = false

@onready var letrae: Sprite2D = $LetraE
@onready var letraEgrande: Sprite2D = $LetraEGrande

var interactuarLinterna = false

@onready var keypad: Control = $Keypad
var puede_interactuar = false

var andresEnArea = false

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
	
	if puede_interactuar and global.labelOK and andresEnArea:
		presiona_f.visible = true
	else:
		presiona_f.visible = false
	
	if puede_interactuar and global.labelOK == true and Input.is_action_just_pressed("interactuarF"):
		await get_tree().process_frame
		await get_tree().create_timer(0.5).timeout
		trans.cambiarEscena("res://Escenarios/PasilloRecuerdos/pasilloRecuerdos.tscn")
		musica.stop()
	if global.labelOK == true:
		keypad.visible = false

	if interactuarA and Input.is_action_pressed("presionarE"):
		letraAgrande.visible = true
	else:
		letraAgrande.visible = false
	if interactuarE and Input.is_action_pressed("presionarE"):
		letrah5grande.visible = true
	else:
		letrah5grande.visible = false
	
	if interactuarLinterna and Input.is_action_pressed("presionarE"):
		linternaLuz.visible = true
		global.tieneLinterna = true
		$Linterna.visible = false
	
	if global.skipdialogue:
		reanudarPersonaje()
		global.skipdialogue = false

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
	

func _on_area_presionar_body_entered(body: Node2D) -> void:
	if body == $Andres:
		andresEnArea = true
		if global.labelOK:
			puede_interactuar = true
			presiona_f.visible = true
		keypad.visible = true
	

func _on_area_presionar_body_exited(body: Node2D) -> void:
	if body == $Andres:
		andresEnArea = false
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
	investigar_E.visible = true
	interactuarE = true


func _on_letrah_5_body_exited(body: Node2D) -> void:
	body = $Andres
	investigar_E.visible = false
	maspergaminos()
	interactuarE = false


func _on_letra_e_body_entered(body: Node2D) -> void:
	body = $Andres
	letraEgrande.visible = true


func _on_letra_e_body_exited(body: Node2D) -> void:
	body = $Andres
	maspergaminos()
	letraEgrande.visible = false

var yadialogo = true
func _on_linterna_area_body_entered(body: Node2D) -> void:
	interactuarLinterna = true
	if yadialogo:
		pausarPersonaje()
		DialogueManager.show_dialogue_balloon(load("res://Dialogos/Level0/Tutorial.dialogue"), "linteraencontrada")
		yadialogo = false

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


func _on_abrir_opciones_body_entered(body: Node2D) -> void:
	global.abrirOpciones = true


func _on_letrah_3_body_entered(body: Node2D) -> void:
	letrah3Grande.visible = true


func _on_letrah_3_body_exited(body: Node2D) -> void:
	letrah3Grande.visible = false


func _on_dialogolinterna_zona_body_entered(body: Node2D) -> void:
	pausarPersonaje()
	DialogueManager.show_dialogue_balloon(load("res://Dialogos/Level0/Tutorial.dialogue"), "linternazona")
	$DialogolinternaZona.queue_free()
