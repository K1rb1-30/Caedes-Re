extends Node2D


@export var enemigo_escena: PackedScene = preload("res://assets/enemies/MINIONS/enemy_minion.tscn")
var Andres = null
@export var cantidad = 5
@onready var puertas: TileMapLayer = $Suelo/Puertas
@onready var puerta_colision: StaticBody2D = $puertaColision
@onready var camera_2d: Camera2D = $Andres/Camera2D

var posicion_enemigos = [
	Vector2(831,511),
	Vector2(661, 688),
	Vector2(904, 690),
	Vector2(586, 530),
	Vector2(688, 587)
]

func _ready() -> void:
	global.puedeMoverse = false
	playAnimationCandelario("candelario")
	playAnimationAntorcha("antorcha")
	#for posicion in posicion_enemigos:
		#spawn_enemigo(posicion)
		
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("presionarE"):
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
	if body.is_in_group("andres"):
		Andres = body
		puertas.visible = true
		puerta_colision.collision_mask = 1
		puerta_colision.collision_layer = 1
		
