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
