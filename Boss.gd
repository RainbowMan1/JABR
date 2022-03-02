extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var health = 100
var max_health = 100
var target = null
var projectile = preload("res://Projectile/Projectile.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	self.get_parent().updateGameState()
	print("Boss starts with ", health, " health")


func _physics_process(delta):
	#test code the boss should take damage when the space button is pressed
	if health == 0:
		die()
	if Input.is_action_just_pressed("ui_select"):
		shoot()

func take_damage(damage):
	if (health - damage) <= 0:
		health = 0
	else:
		health -= damage
	print("Boss has ", health, " health")
	
func die():
	queue_free()


func _on_Area2D_area_entered(area):
	pass

func shoot():
	var proj = projectile.instance()
	if (target != null):
		var target_direction_x = target.position.x-position.x
		var target_direction_y = target.position.y-position.y
		print(target.position.x, ", ", target.position.y)
		proj.direction = target.position - position
	add_child(proj)

func _on_PlayerDetection_body_entered(body):
	if (body.name == "PlayerBase"):
		target = body
