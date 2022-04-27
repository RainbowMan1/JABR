extends KinematicBody2D
class_name Boss

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var health = 100
var max_health = 100
var target = null
var projectile = preload("res://Projectile/Projectile.tscn")
var rng = RandomNumberGenerator.new()

onready var shootTimer = get_node("Shoot_Timer")
# Called when the node enters the scene tree for the first time.
func _ready():
	if get_parent().name == "Arena":
		self.get_parent().updateGameState()
	print("Boss starts with ", health, " health")
	shootTimer.set_wait_time(2)
	shootTimer.start()

func _physics_process(delta):
	#test code the boss should take damage when the space button is pressed
	if health <= 0:
		die()

func die():
	queue_free()


func _on_Area2D_area_entered(area):
	#print(get_tree().get_nodes_in_group("player_attack"))
	if(area.is_in_group("player_attack")):
		health -= area.damage
		$Boss_cry.play(0.0)
		print("Boss has ", health, " health")
	self.get_parent().updateBossHealth(health)

func shoot():
	if (target != null):
		var proj = projectile.instance()
		rng.randomize()
		var scaler = rng.randf_range(0.5, 1.5)
		proj.scale = Vector2(scaler, scaler)
		var target_direction_x = target.position.x-position.x
		var target_direction_y = target.position.y-position.y
		#print(target.position.x, ", ", target.position.y)
		proj.direction = target.position - position
		add_child(proj)

func _on_PlayerDetection_body_entered(body):
	if (body.name == "PlayerBase"):
		target = body

func _on_Shoot_Timer_timeout():
	shoot() # Replace with function body.


func _on_PlayerBase_tree_exiting():
	target = null # Replace with function body.
