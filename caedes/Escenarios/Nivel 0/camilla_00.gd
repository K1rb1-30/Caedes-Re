extends Node2D


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

	
