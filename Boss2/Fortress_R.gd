extends "res://Boss.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	projectile = preload("res://Projectile/Cannon.tscn")
	if get_parent().name == "Arena":
		self.get_parent().updateGameState()
	print("Boss starts with ", health, " health")
	shootTimer.set_wait_time(2)
	shootTimer.start()
	
func _on_Area2D_area_entered(area):
	#print(get_tree().get_nodes_in_group("player_attack"))
	if(area.is_in_group("player_attack")):
		health -= area.damage
		$TowerHealth.value = health
		#print("Boss has ", health, " healthR")

func die():
	for i in self.get_children():
		print(i)
		if (i.is_in_group("Barrier")):
			i.queue_free()
	$Sprite.texture = load("res://Ruined_Fortress.png")
	$Shoot_Timer.set_paused(true)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
