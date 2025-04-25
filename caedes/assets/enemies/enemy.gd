extends CharacterBody2D

@export var velocida = 70
var playerChase = false
var Andres = null

@export var healthEnemy = 100
var canTakeDamage = true

func _physics_process(delta):
	dealWithDamage()
	update_health()
	
	if playerChase:
		var direccion = (Andres.position - position).normalized()
		velocity = direccion * velocida
		move_and_slide()
	else:
		velocity = Vector2.ZERO
		move_and_slide()
func _on_detection_area_body_entered(body):
	if body.is_in_group("andres"):
		Andres = body
		playerChase = true
		print("area dentro")


func _on_detection_area_body_exited(body):
	Andres = null
	playerChase = false
	print("area fuera")
	
func _on_enemy_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("andres"):
		global.andresInattackZone = true
		print("Andrés entró en el rango de ataque")


func _on_enemy_hitbox_body_exited(body: Node2D) -> void:
	if body.is_in_group("andres"):
		global.andresInattackZone = false
		print("Andrés salió del rango de ataque")

		
func dealWithDamage():
	if global.andresInattackZone and global.andresCurrentAttack and canTakeDamage:
		print("CAN TAKE DAMAGE")
		canTakeDamage = false
		healthEnemy = healthEnemy - 20
		print("enemy health = ", healthEnemy)
		global.andresCurrentAttack = false
		$damageCooldown.start()
		if healthEnemy <= 0:
			self.queue_free()
			

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
