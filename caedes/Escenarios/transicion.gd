extends CanvasLayer

@onready var anim: AnimationPlayer = $AnimationPlayer
func _ready():
	layer = -1
	get_node("AnimationPlayer").play("trans")
func cambiarEscena(path : String) -> void:
	layer = 1
	anim.play("trans")
	await (anim. animation_finished)
	get_tree().change_scene_to_file(path)
	anim.play_backwards("trans")
	await (anim. animation_finished)
	layer = -1
