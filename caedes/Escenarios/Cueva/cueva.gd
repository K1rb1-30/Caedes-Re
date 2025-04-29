extends Node2D
@onready var camera_2d: Camera2D = $Andres/Camera2D
@onready var presiona_f: Label = $Andres/PresionaF

func _ready() -> void:
	camera_2d.limit_bottom = 1263.0
	camera_2d.limit_right = 1328.0
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	presiona_f.visible = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	presiona_f.visible = false
