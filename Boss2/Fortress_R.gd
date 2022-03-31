extends "res://Boss.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Area2D_area_entered(area):
	#print(get_tree().get_nodes_in_group("player_attack"))
	if(area.is_in_group("player_attack")):
		health -= area.damage
		print("Boss has ", health, " healthR")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
