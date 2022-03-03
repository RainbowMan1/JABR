extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var health = 100
var max_health = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	self.get_parent().updateGameState()
	print("Boss starts with ", health, " health")

func _physics_process(delta):
	#test code the boss should take damage when the space button is pressed
	if health <= 0:
		die()

func die():
	queue_free()


func _on_Area2D_area_entered(area):
	health -= area.damage
	print("Boss has ", health, " health")
