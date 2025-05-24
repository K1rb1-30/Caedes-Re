extends CharacterBody2D

@export var mecheroEscena: PackedScene
@export var velocida = 70
var playerChase = false
var Andres = null
@onready var enemigoSprite: AnimatedSprite2D = $AnimatedSprite2D
@export var healthEnemy: int = 10
var canTakeDamage = true
var andresInAttackZone = false
var estaAtacando = false
@onready var ataqueTimer: Timer = $ataqueTimer

func _physics_process(delta):
	dealWithDamage()
	if playerChase:
		var direccion = (Andres.position - position).normalized()
		# Esto es la separacion entre cada enemigo
		var separacion = Vector2.ZERO
		# Recorre todos los nodos que estan en el grupo "enemy"
		for other in get_tree().get_nodes_in_group("enemy"):
			# Asegura que el other no sea el mismo que este enemigo self y que sea un tipo characterbody2d
			# El self es para verificar que no sea el mismo nodo
			# porque si no se hace calcularia su distancia consigo mismo, que sería 0
			if other != self and other is CharacterBody2D:
				var distancia = position.distance_to(other.position)
				if distancia < 50:
					separacion += (position - other.position).normalized() / distancia
		# Calcula un vector ortogonal a la dirección del jugador.
		var anguloDesplazado = (position - Andres.position).orthogonal().normalized() * 0.5
		direccion += separacion * 1.5  # fuerza de separación
		direccion += anguloDesplazado * 0.8 # fuerza para rodear

		velocity = direccion * velocida
		move_and_slide()
		if !estaAtacando:
			enemigoSprite.play("walk")
		
		if direccion.x < 0:
			enemigoSprite.flip_h = true
		elif direccion.x > 0:
			enemigoSprite.flip_h = false
		
	else:
		velocity = Vector2.ZERO
		move_and_slide()
		if !estaAtacando:
			enemigoSprite.play("idle")
func _on_detection_area_body_entered(body):
	if body.is_in_group("andres"):
		Andres = body
		playerChase = true
		print("area dentro")


func _on_detection_area_body_exited(body: CharacterBody2D) -> void:
	if body.is_in_group("andres"):
		Andres = body
		playerChase = false
		print("area fuera")
	

func _on_enemy_hitbox_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("andres"):
		andresInAttackZone = true
		if !estaAtacando:
			estaAtacando = true
			enemigoSprite.play("attack")
			ataqueTimer.start()
			print("Andrés entró en el rango de ataque")


func _on_enemy_hitbox_body_exited(body: Node2D) -> void:
	if body.is_in_group("andres"):
		andresInAttackZone = false
		print("Andrés salió del rango de ataque")

		
func dealWithDamage():
	if andresInAttackZone and global.andresCurrentAttack and canTakeDamage:
		print("CAN TAKE DAMAGE")
		canTakeDamage = false
		healthEnemy -= 20
		Andres.sumar_cordura(10)
		print("enemy health = ", healthEnemy)
		global.andresCurrentAttack = false
		$damageCooldown.start()
		if healthEnemy <= 0:
			print("enemigo minion muerto")
			morir()
			

func _on_damage_cooldown_timeout() -> void:
	print("ON DAMAGE COOLDOWN TIMEOUT")
	canTakeDamage = true

func morir():
	print(global.nietoVivos)
	global.nietoVivos -= 1
	if global.nietoVivos <= 0 and !global.mecheroMostrado:
		global.mecheroMostrado = true
		var mechero = mecheroEscena.instantiate()
		get_tree().current_scene.add_child(mechero)
		mechero.global_position = self.global_position
	self.queue_free()


func _on_ataque_timer_timeout() -> void:
	estaAtacando = false
	playerChase = true
	if Andres != null and Andres.is_in_group("andres") and global.andresInattackZone:
		estaAtacando = true
		enemigoSprite.play("attack")
		ataqueTimer.start()
		playerChase = true
