extends CharacterBody2D

var enemyAttackRange = false
var enemyAttackCooldown = true
var health = 100
var cordure = 100
var andresVivo = true
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
		sprite2d.flip_h = false
	
		
		
		
	velocity = velocity.normalized() * speed
	move_and_slide()
	attack()
	update_health()
	
	if health <= 0:
		andresVivo = false
		health = 0
		self.queue_free()
		print("andres muerto")

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
	

func attack():
	if Input.is_action_just_pressed("attack"):
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
