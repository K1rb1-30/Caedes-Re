extends CharacterBody2D

var enemyAttackRange = false
var enemyAttackCooldown = true
var health = 400
var andresVivo = true

var ataque = false


func _physics_process(delta):
	var direccion = Input.get_vector("left", "right", "up", "down")
	velocity = direccion * 150
	move_and_slide()
	enemy_Attack()
	attack()
	
	if health <= 0:
		andresVivo = false
		health = 0
		self.queue_free()
		print("andres muerto")

func player():
	pass

func _on_andres_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemyAttackRange = true
		


func _on_andres_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemyAttackRange = false
		

func _on_attack_cooldown_timeout() -> void:
	enemyAttackCooldown = true

func enemy_Attack():
	if enemyAttackRange and enemyAttackCooldown:
		health = health - 20
		enemyAttackCooldown = false
		$attackCooldown.start()
		print(health)
		
func attack():
	if Input.is_action_just_pressed("attack"):
		global.andresCurrentAttack = true
		$dealAttackTimer.start()
		

func _on_deal_attack_timer_timeout() -> void:
	$dealAttackTimer.stop()
	global.andresCurrentAttack = false
	ataque = false
