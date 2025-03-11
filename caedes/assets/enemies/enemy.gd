extends CharacterBody2D

var velocida = 64
var playerChase = false
var Andres = null
var andresInattackZone = false

var healthEnemy= 100

func _physics_process(delta):
	dealWithDamage()
	
	if playerChase:
		var direccion =(Andres.position - position).normalized()
		position += direccion * velocida * delta
func _on_detection_area_body_entered(body):
	Andres = body
	playerChase = true


func _on_detection_area_body_exited(body):
	Andres = null
	playerChase = false
	
func enemy():
	pass


func _on_enemy_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("andres"):
		global.andresInattackZone = true

func _on_enemy_hitbox_body_exited(body: Node2D) -> void:
	if body.is_in_group("andres"):
		global.andresInattackZone = false
		
func dealWithDamage():
	if andresInattackZone and global.andresCurrentAttack:
		healthEnemy = global.healthEnemy - 20
		print("enemy health = ", healthEnemy)
		if healthEnemy <= 0:
			self.queue_free()
