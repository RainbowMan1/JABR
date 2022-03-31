extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var fsm: WeakRef

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func updateBossHealth(val):
	$BossHealthBar.value = val
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Fly_Trap_tree_exited():
	fsm.get_ref().next()
