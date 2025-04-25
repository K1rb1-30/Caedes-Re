extends CharacterBody2D

@export var velocida = 70
var playerChase = false
var Andres = null
@onready var enemigoSprite: AnimatedSprite2D = $AnimatedSprite2D
@export var healthEnemy = 100
var canTakeDamage = true

func _physics_process(delta):
	dealWithDamage()
	
	if playerChase:
		var direccion = (Andres.position - position).normalized()
		velocity = direccion * velocida
		move_and_slide()
		enemigoSprite.play("walk")
	else:
		velocity = Vector2.ZERO
		move_and_slide()
		enemigoSprite.play("idle")
func _on_detection_area_body_entered(body):
	if body.is_in_group("andres"):
		Andres = body
		playerChase = true
		print("area dentro")


func _on_detection_area_body_exited(body: CharacterBody2D) -> void:
	Andres = null
	playerChase = false
	print("area fuera")
	

func _on_enemy_hitbox_body_entered(body: CharacterBody2D) -> void:
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
		healthEnemy -= 20
		print("enemy health = ", healthEnemy)
		global.andresCurrentAttack = false
		$damageCooldown.start()
		if healthEnemy <= 0:
			self.queue_free()
			print("enemigo minion muerto")
			

func _on_damage_cooldown_timeout() -> void:
	print("ON DAMAGE COOLDOWN TIMEOUT")
	canTakeDamage = true
