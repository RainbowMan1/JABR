extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var health = 100
var max_health = 100
var target = null
var projectile = preload("res://Projectile/PoisonProjectile.tscn")
onready var shootTimer = get_node("Shoot_Timer")
# Called when the node enters the scene tree for the first time.
func _ready():
	if get_parent().name == "Arena":
		self.get_parent().updateGameState()
	print("Boss starts with ", health, " health")
	shootTimer.set_wait_time(.5)
	shootTimer.start()
	setTimer("teleport",1.25)

func _physics_process(delta):
	
	#test code the boss should take damage when the space button is pressed
	if health <= 0:
		queue_free()#kills the boss if it's health is less than 0

#creates a timer based on what function you want to do and how long you want the timer to last
func setTimer(spawn_func, spawn_time) -> Timer:
	var timer = Timer.new()
	add_child(timer)
	timer.set_wait_time(spawn_time)
	timer.connect("timeout", self, spawn_func) 
	timer.start()
	return timer

func _on_Area2D_area_entered(area):
	#print(get_tree().get_nodes_in_group("player_attack"))
	if(area.is_in_group("player_attack")):
		$Boss_cry.play(0.0)
		health -= area.damage
		print("Boss has ", health, " health")
		if(self.get_parent().has_method("updateBossHealth")):
			self.get_parent().updateBossHealth(health)

func shoot():
	if (target != null):
		var proj = projectile.instance()
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

func teleport():#teleports the flytrap around the axis of the map e.x. (1,1) -> (-1,1)
	print(get_viewport().size.x)
	print(get_viewport().size.y)
	global_position.x = (randi() % int(get_viewport().size.x/8))
	global_position.y = (randi() % int(get_viewport().size.y/8))
	print("new ", position)
