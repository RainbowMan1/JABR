extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var fsm: WeakRef

var clock = 0 
var time_multi = 1.0
var killed = false 

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Next Scene")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	clock += delta * time_multi 
#	pass

func updateBossHealth(val):
	$BossHealthBar.value = val


func _on_Boss_tree_exited():
	if (get_node("PlayerBase") != null):
		fsm.get_ref().scoreData(clock, get_node("PlayerBase").health)
		fsm.get_ref().next() # Replace with function body.

func _on_PlayerBase_tree_exited():
	if(killed):
		print_debug("Player Killed")
		fsm.get_ref().playerLost()
	
