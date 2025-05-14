extends Node2D


@export var enemigo_escena: PackedScene = preload("res://assets/enemies/MINIONS/enemy_minion.tscn")
@onready var andres: CharacterBody2D = $Andres
@export var cantidad = 5
@onready var puertas: TileMapLayer = $Suelo/Puertas
@onready var puerta_colision: StaticBody2D = $puertaColision
@onready var camera_2d: Camera2D = $Andres/Camera2D
@onready var presiona_f: Label = $Andres/PresionaF
@onready var letrakGrande: Sprite2D = $LetraKGrande
@onready var letrak: Sprite2D = $LetraK
@onready var letraAgrande: Sprite2D = $LetraAGrande
var interactuarA = false


@onready var keypad: Control = $Keypad
var puede_interactuar = false
@onready var musica: AudioStreamPlayer = $Musica

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
	#for posicion in posicion_enemigos:
	#	spawn_enemigo(posicion)
		
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("presionarE"): 
		global.puedeMoverse = true
	if puede_interactuar and global.labelOK == true and Input.is_action_just_pressed("interactuarF"):
		await get_tree().process_frame
		await get_tree().create_timer(0.5).timeout
		trans.cambiarEscena("res://Escenarios/Cueva/cueva.tscn")
		musica.stop()
	if global.labelOK == true:
		keypad.visible = false
	if interactuarA and Input.is_action_pressed("attack"):
		letraAgrande.visible = true
		andres.visible = false
		global.puedeMoverse = false
	else:
		letraAgrande.visible = false
		andres.visible = true
		global.puedeMoverse = true

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


func _on_letra_k_body_entered(body: Node2D) -> void:
	body = $Andres
	letrakGrande.visible = true
	letrak.visible = true
	andres.visible = false

func _on_letra_k_body_exited(body: Node2D) -> void:
	body = $Andres
	letrakGrande.visible = false
	letrak.visible = true

func _on_letra_a_body_entered(body: Node2D) -> void:
	body = $Andres
	interactuarA = true

func _on_letra_a_body_exited(body: Node2D) -> void:
	body = $Andres
	interactuarA = false
