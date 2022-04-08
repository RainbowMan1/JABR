extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var fsm: WeakRef

var clock = 0 
var time_multi = 1.0 

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
	fsm.get_ref().scoreData(clock, get_node("PlayerBase").health)
	fsm.get_ref().next()
