extends Node2D

@onready var andresScript: Script = load("res://assets/character/andres/characterAndresWASD.gd")
@onready var enemyScript: Script = load("res://assets/enemies/enemy.gd")
@onready var andres: CharacterBody2D = $Andres
@onready var enemy: CharacterBody2D = $Enemy
var scriptActive = false

func _ready():
	playAnimationCandelario("candelario")
	playAnimationAntorcha("antorcha")
	

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


	
