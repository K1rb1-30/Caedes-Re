extends CharacterBody2D
class_name gato

var speed = 190  # Velocidad de movimiento
var player = null

func _ready():
	# Obtén el jugador (asegúrate de que esté en el grupo "player")
	player = get_tree().get_nodes_in_group("player")[0]

func _process(delta: float) -> void:
	follow()
	
func follow():
	if player != null:
		# Calcula la dirección solo en el eje X
		var direction = sign(player.position.x - position.x)  # Devuelve -1 (izquierda), 0 (igual), o 1 (derecha)
		# Aplica la velocidad
		velocity = Vector2(direction * speed, 0)
		# Mueve el personaje usando move_and_slide()
		move_and_slide()
