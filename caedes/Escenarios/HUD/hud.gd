extends Control
class_name HUD
@onready var sprite: AnimatedSprite2D = $HBoxContainer/VBoxContainer/EstadoHUD/Sprite/AnimatedSprite2D
@onready var BarraVida: TextureProgressBar = $HBoxContainer/VBoxContainer/VidaHUD/VIDA/BarraVida
@onready var BarraCordura: TextureProgressBar = $HBoxContainer/VBoxContainer/EstadoHUD/CORDURA/BarraCordura

@export var Vida : NodePath
@export var Cordura : NodePath
@export var Flash : NodePath

@onready var restarVida = get_node(Vida)
@onready var restarCordura = get_node(Cordura)
@onready var flashVida = get_node(Flash)

"""
Me tira pa' que yo la pruebe
Se pone olorosa y me gusta cómo huele (Cómo huele)
Instagram privado, pa' que nadie la vele
Se puso bonita porque sabe que hoy se bebe
A portarse mal pa' sentirse bien
No quería fumar, pero le dio al pen (Sí)
Una Barbie, pero no busca un Ken (No)
Siempre le llego cuando dice "Ven"
"""

func _process(delta: float) -> void:
		BarraVida.value = restarVida.health #Actualiza la barra de vida a la del jugador
		BarraCordura.value = restarCordura.cordure #Actualiza la barra de cordura a la del jugador
		var flash = restarVida.flash
		if flash:
			flash_screen()
	# VOY POR AQUI
		if BarraCordura.value < 50 and BarraCordura.value > 20:
			cordura_ojos()
		elif BarraCordura.value < 20:
			cordura_luna()

func flash_screen():
	$AnimationPlayer.play("flash")

func cordura_ojos():
	$AnimationPlayer.play("Ojos")
	
func cordura_luna():
	$AnimationPlayer.play("Luna")
	
func _ready() -> void:
	sprite.play("Default")
