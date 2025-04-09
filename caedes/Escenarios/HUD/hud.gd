extends Control
class_name HUD
@onready var sprite: AnimatedSprite2D = $HBoxContainer/VBoxContainer/EstadoHUD/AnimatedSprite2D
@onready var BarraVida: TextureProgressBar = $HBoxContainer/VBoxContainer/VidaHUD/VIDA/BarraVida
@onready var BarraCordura: TextureProgressBar = $HBoxContainer/VBoxContainer/EstadoHUD/CORDURA/BarraCordura



@export var Vida : NodePath
@export var Cordura : NodePath

@onready var restarVida = get_node(Vida)
@onready var restarCordura = get_node(Cordura)

func _process(delta: float) -> void:
	BarraVida.value = restarVida.health
	#BarraCordura.value -= restarCordura

func _ready() -> void:
	sprite.play("Default")
