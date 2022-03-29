extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var fsm: WeakRef

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Next Scene")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func updateBossHealth(val):
	$BossHealthBar.value = val


func _on_Boss_tree_exited():
	fsm.get_ref().next()
