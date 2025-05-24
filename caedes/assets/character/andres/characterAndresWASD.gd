extends CharacterBody2D

var enemyAttackRange = false
var enemyAttackCooldown = true
var cordure = 100
var health = 100
var andresVivo = true
var flash = false #Para que flashee la imagen
@onready var sprite2d: AnimatedSprite2D = $Sprite2D
@onready var menu_pausa: Control = $MenuPausa
@onready var presionaFmechero: Label = $PresionaFMechero
@onready var attackTimer: Timer = $attackTimer
var estaAtacando = false
var direccionActual = "abajo"

func _physics_process(delta):
		
	velocity = Vector2.ZERO
	var speed:int = 100
	if global.puedeMoverse:
		if !estaAtacando:
			if Input.is_action_pressed("right"):
				velocity += Vector2(1, 0)
				direccionActual = "derecha"
				sprite2d.play("Izquierda")
				sprite2d.flip_h = true
				global.puedeMoverse = true	
				
			elif Input.is_action_pressed("left"):
				velocity += Vector2(-1, 0)
				direccionActual = "izquierda"
				sprite2d.play("Izquierda")
				sprite2d.flip_h = false
				global.puedeMoverse = true
				
			elif Input.is_action_pressed("up"):
				velocity += Vector2(0, -1)
				direccionActual = "arriba"
				sprite2d.play("DeAtras")
				sprite2d.flip_h = false
			elif Input.is_action_pressed("down"):
				direccionActual = "abajo"
				velocity += Vector2(0, 1)
				sprite2d.play("DeFrente")
				sprite2d.flip_h = false
			if velocity == Vector2(0, 0) :
				sprite2d.play("StaticAbuelo")
				sprite2d.flip_h = false	
		else:
			if estaAtacando:
				match direccionActual:
					"izquierda":
						sprite2d.play("AtaqueIzquierda")
						sprite2d.flip_h = false
					"derecha":
						sprite2d.play("AtaqueIzquierda")
						sprite2d.flip_h = true
					"arriba":
						sprite2d.play()
	else:
		sprite2d.play("StaticAbuelo")
		
	
	if global.abrirOpciones and Input.is_action_just_released("escape"):
		menu_pausa.visible = true
		global.puedeMoverse = false
		print("menu visible")
		
	if global.labelMechero:
		presionaFmechero.visible = true
	else:
		presionaFmechero.visible = false
		
		

	velocity = velocity.normalized() * speed
	move_and_slide()
	attack()
	
	# MODO DE CORDURA
	if global.CordureMode:
		cordure -= delta
		if cordure <= 0:
			cordure = 0
			global.CordureMode = false
		else:
			update_cordure()
			#print(cordure)
	
	#Si esta muerto
	if health <= 0:
		andresVivo = false
		health = 0
		global.puedeMoverse = false
		print("andres muerto")
		mostrar_muerte()
		

func mostrar_muerte():
	var escena_muerte = preload("res://Escenarios/Muerte/PantallaMuerte.tscn").instantiate()
	get_tree().current_scene.add_child(escena_muerte)
	escena_muerte.mostrar()

# FUNCIONALIDAD -- CORDURA

	#Actualizar Cordura cada Segundo
func update_cordure():
	var minutes = int(cordure) / 60
	var seconds = int(cordure) % 60
	
	#Sumar cordura
func sumar_cordura(extra: float):
	cordure += extra
	update_cordure()
	
	#Restar cordura
func restar_cordura(extra: float):
	cordure -= extra
	update_cordure()

func _on_andres_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		enemyAttackRange = true
		$attackCooldown.start()
		
		
func _on_andres_hitbox_body_exited(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		enemyAttackRange = false
		

func _on_attack_cooldown_timeout() -> void:
	if enemyAttackRange:
		enemy_Attack()
		$attackCooldown.start()

func enemy_Attack():
	health = health - 20
	flash = true
	restar_cordura(10)#Resta 10 de cordura
	await get_tree().create_timer(1.0).timeout  # Espera 1 segundos para qie se re
	flash = false
	print(health)
	

func attack():
	if Input.is_action_just_pressed("attack"):
		global.andresCurrentAttack = true
		velocity = Vector2.ZERO
		estaAtacando = true
		attackTimer.start()
				
func _on_deal_attack_timer_timeout() -> void:
	global.andresCurrentAttack = false


func _on_attack_timer_timeout() -> void:
	estaAtacando = false
	global.andresCurrentAttack = false
