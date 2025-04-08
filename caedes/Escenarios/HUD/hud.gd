extends Control
class_name HUD
@onready var sprite: AnimatedSprite2D = $HBoxContainer/VBoxContainer/EstadoHUD/AnimatedSprite2D
@onready var BarraVida: TextureProgressBar = $HBoxContainer/VBoxContainer/VidaHUD/VIDA/BarraVida
@onready var BarraCordura: TextureProgressBar = $HBoxContainer/VBoxContainer/EstadoHUD/CORDURA/BarraCordura

@export var Vida : Node
@export var Estado : Node

func _process(delta: float) -> void:
	BarraVida.value -= 1
	BarraCordura.value -= 1

func update_vida(number : int):
	Vida.text = "x" + str(number)
	
func update_paniquea(number : int):
	Estado.text = "Estas Paniqueando"

func _ready() -> void:
	sprite.play("Default")
