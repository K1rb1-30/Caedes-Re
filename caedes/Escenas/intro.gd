extends Node2D

@onready var andres: CharacterBody2D = $Andres
@onready var enemy: CharacterBody2D = $Enemy
@onready var intro: Sprite2D = $Intro
@onready var intro_sin: Sprite2D = $IntroSin
@onready var andresScript: Script = load("res://assets/character/andres/characterAndresWASD.gd")
@onready var enemyScript: Script = load("res://assets/enemies/enemy.gd")
func _ready():
	andres.set_script(null)
	enemy.set_script(null)
	

func _physics_process(delta):
	if Input.is_action_pressed("presionarE"):
		andres.visible = true
		enemy.visible = true
		andres.set_deferred("disabled", "true")
		intro.visible = false
		andres.set_script(andresScript)
		enemy.set_script(enemyScript)
		intro_sin.visible = true
		
		
