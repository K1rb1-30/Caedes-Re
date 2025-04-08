extends CanvasLayer

@export var player_node : Node

#func _process(delta: float) -> void:
	#$TextureProgressBar.value - player_node
