extends Node2D
@onready var camera_2d: Camera2D = $Andres/Camera2D

func _ready() -> void:
	camera_2d.limit_bottom = 1263.0
	camera_2d.limit_right = 1328.0
	
