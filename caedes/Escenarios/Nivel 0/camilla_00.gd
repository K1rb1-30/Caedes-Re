extends Node2D

@export var enemigo_escena: PackedScene = preload("res://assets/enemies/MINIONS/enemy_minion.tscn")

@export var cantidad = 5


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
	
func _ready() -> void:
	playAnimationCandelario("candelario")
	playAnimationAntorcha("antorcha")
	for i in cantidad:
		spawn_enemigo(Vector2(500 + i * 100, 500)) # ejemplo con posiciones separadas

	
