extends CanvasLayer

@export var escena: String
func cambiarEscena():
	print("Escena a cargar: ", escena)
	get_tree().change_scene_to_file(escena)
func start():
	await get_tree().process_frame
	$AnimationPlayer.play("fade")
	await $AnimationPlayer.animation_finished
	cambiarEscena()
