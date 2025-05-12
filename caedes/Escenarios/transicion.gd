extends CanvasLayer
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var audioStream: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready():
	layer = -1
	get_node("AnimationPlayer").play("trans")
func cambiarEscena(path : String) -> void:
	layer = 1
	anim.play("trans")
	audioStream.play()
	await (anim. animation_finished)
	get_tree().change_scene_to_file(path)
	anim.play_backwards("trans")
	await (anim. animation_finished)
	layer = -1
