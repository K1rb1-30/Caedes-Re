extends Control

@onready var creditos: RichTextLabel = $Creditos
var velocidad = 30 
var posicionInicial
var posicionFinal

func _ready():
	await get_tree().process_frame  # Espera 1 frame para que se actualice el layout
	var ancho_label = creditos.get_minimum_size().x
	posicionInicial = Vector2((self.size.x - ancho_label) / 2, self.size.y)
	posicionFinal = Vector2(posicionInicial.x, -creditos.size.y)
	creditos.position = posicionInicial

func _process(delta):
	if creditos.position.y > posicionFinal.y:
		creditos.position.y -= velocidad * delta
