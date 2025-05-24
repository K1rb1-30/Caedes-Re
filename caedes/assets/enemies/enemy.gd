extends CharacterBody2D

@export var velocida = 70
var playerChase = false
var Andres = null
@onready var enemigoSprite: AnimatedSprite2D = $enemigoSprite

@export var healthEnemy = 100
var canTakeDamage = true
@export var cartelEscena: PackedScene
var estaAtacando = false
@onready var ataqueTimer: Timer = $ataqueTimer

func _physics_process(delta):
	dealWithDamage()
	update_health()
	
	if playerChase and !estaAtacando:
		var direccion = (Andres.position - position).normalized()
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


func _on_detection_area_body_exited(body):
	if body.is_in_group("andres"):
		Andres = body
		playerChase = false
		print("area fuera")
	
func _on_enemy_hitbox_body_entered(body) -> void:
	if body.is_in_group("andres") and !estaAtacando:
		global.andresInattackZone = true
		if !estaAtacando:
			estaAtacando = true
			enemigoSprite.play("attack")
			ataqueTimer.start()
			print("Andrés entró en el rango de ataque")


func _on_enemy_hitbox_body_exited(body) -> void:
	if body.is_in_group("andres"):
		global.andresInattackZone = false
		print("Andrés salió del rango de ataque")

		
func dealWithDamage():
	if global.andresInattackZone and global.andresCurrentAttack and canTakeDamage:
		print("CAN TAKE DAMAGE")
		canTakeDamage = false
		healthEnemy -= 20
		print("enemy health = ", healthEnemy)
		global.andresCurrentAttack = false
		$damageCooldown.start()
		if healthEnemy <= 0:
			self.queue_free()
			var cartel = cartelEscena.instantiate()
			get_tree().current_scene.add_child(cartel)
			cartel.global_position = self.global_position

	
			#Le sale un dialogo al jugador de la barra de vida y no permite moverse al jugador y todododododo 
			global.puedeMoverse = false
			DialogueManager.show_dialogue_balloon(load("res://Dialogos/Level0/Tutorial.dialogue"), "tutocombateEnemigoEliminado")
			
			#Si no se han visto mas pergaminos te sale el dialogo de mas pergaminos
			#if global.segundopergamino:
			#	DialogueManager.show_dialogue_balloon(load("res://Dialogos/Level0/Tutorial.dialogue"), "maspergaminos")
			#	global.segundopergamino = false #Setea la variable en false para saber que ya se ha visto un segundo pergamino
				
			

func _on_damage_cooldown_timeout() -> void:
	print("ON DAMAGE COOLDOWN TIMEOUT")
	canTakeDamage = true

func update_health():
	var healthbar = $healthbar
	healthbar.value = healthEnemy
	
	if healthEnemy >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true


func _on_ataque_timer_timeout() -> void:
	estaAtacando = false
	playerChase = true
	if Andres != null and Andres.is_in_group("andres") and global.andresInattackZone:
		estaAtacando = true
		enemigoSprite.play("attack")
		ataqueTimer.start()
		playerChase = true
