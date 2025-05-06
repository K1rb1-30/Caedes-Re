extends CharacterBody2D

@export var CordureMode : bool

var enemyAttackRange = false
var enemyAttackCooldown = true
var health = 100
var cordure = 100
var andresVivo = true
var flash = false #Para que flashee la imagen
@onready var sprite2d: AnimatedSprite2D = $Sprite2D

var ataque = false


func _physics_process(delta):
	#var direccion = Input.get_vector("left", "right", "up", "down")
	#velocity = direccion * 150
	#move_and_slide()
	velocity = Vector2.ZERO
	var speed:int = 100
	
	if Input.is_action_pressed("right"):
		velocity += Vector2(1, 0)
		sprite2d.play("Izquierda")
		sprite2d.flip_h = true
		
	elif Input.is_action_pressed("left"):
		velocity += Vector2(-1, 0)
		sprite2d.play("Izquierda")
		sprite2d.flip_h = false
		
	elif Input.is_action_pressed("up"):
		velocity += Vector2(0, -1)
		sprite2d.play("DeAtras")
		sprite2d.flip_h = false
	elif Input.is_action_pressed("down"):
		velocity += Vector2(0, 1)
		sprite2d.play("DeFrente")
		sprite2d.flip_h = false
	if velocity == Vector2(0, 0) :
		sprite2d.play("StaticAbuelo")
		
	velocity = velocity.normalized() * speed
	move_and_slide()
	attack()
	update_health()
	
	# MODO DE CORDURA
	if CordureMode:
		cordure -= delta
		if cordure <= 0:
			cordure = 0
			CordureMode = false
		else:
			update_cordure()
			print(cordure)
	
	#Si esta muelto
	if health <= 0:
		andresVivo = false
		health = 0
		self.queue_free()
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
		#$attackCooldown.stop()
		

func _on_attack_cooldown_timeout() -> void:
	if enemyAttackRange:
		enemy_Attack()
		$attackCooldown.start()
		
		

func enemy_Attack():
	#if enemyAttackRange and enemyAttackCooldown:
	health = health - 20
	print(health)
	flash = true
	restar_cordura(10)#Resta 10 de cordura
	await get_tree().create_timer(1.0).timeout  # Espera 1 segundos para qie se re
	flash = false
		
		#enemyAttackCooldown = false
		#$attackCooldown.start()
		
func attack():
	if Input.is_action_just_pressed("attack") and global.andresInattackZone:
			global.andresCurrentAttack = true
			#$dealAttackTimer.start()
			ataque = true
			
func _on_deal_attack_timer_timeout() -> void:
	global.andresCurrentAttack = false
	ataque = false

func update_health():
	var healthbar = $healthbar
	healthbar.value = health
	
	if health >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true
