extends CharacterBody2D

var enemyAttackRange = false
var enemyAttackCooldown = true
var health = 100
var andresVivo = true

var ataque = false


func _physics_process(delta):
	var direccion = Input.get_vector("left", "right", "up", "down")
	velocity = direccion * 150
	move_and_slide()
	enemy_Attack()
	attack()
	update_health()
	
	if health <= 0:
		andresVivo = false
		health = 0
		self.queue_free()
		print("andres muerto")

func player():
	pass

func _on_andres_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		enemyAttackRange = true
		


func _on_andres_hitbox_body_exited(body: Node2D) -> void:
	if body.is_in_group("enemy"):
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
	if Input.is_action_pressed("attack") and global.andresInattackZone:
		global.andresCurrentAttack = true
		$dealAttackTimer.start()
		

func _on_deal_attack_timer_timeout() -> void:
	$dealAttackTimer.stop()
	global.andresCurrentAttack = false
	ataque = false

func update_health():
	var healthbar = $healthbar
	healthbar.value = health
	
	if health >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true

func _on_regin_timer_timeout() -> void:
	if health < 100:
		health = health + 20
		if health > 100:
			health = 100
	if health <= 0:
		health = 0
