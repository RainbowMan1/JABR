extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var fsm: WeakRef
var bossNum = 0
# Called when the node enters the scene tree for the first time.
func _ready():

	#yield(get_tree().create_timer(1), "timeout")
	print_debug("Boss title done")
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	
	#pass
	
func endScene():
	yield(get_tree().create_timer(1), "timeout")
	fsm.get_ref().next()
