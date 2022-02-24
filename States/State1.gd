extends Node

onready var fsm = $StateMachine
#var gameState = preload("res://State1.tscn")
var title = "State 1"
var time = OS.get_ticks_msec()+100


func enter():
	print("Hello from State 1!")
	#gameState.instance()
	#self.get_child(0).modulate.a = 1
	# Exit 2 seconds later
	#print_tree()
	#yield(get_tree().create_timer(5.0), "timeout")
	#exit(1)

func exit(next_state):
	print_debug("exiting state 1")
	#self.get_child(0).modulate.a = 0
	fsm.change_to(next_state)
	pass

####################################################
### Optional handler functions for game loop events.
### Delete the ones that you don't need.
####################################################
func process(_delta):
	# Replace pass with your handler code
	pass

func physics_process(_delta):
	pass

func input(_event):
	pass

func unhandled_input(_event):
	pass

func unhandled_key_input(_event):
	pass

func notification(_what, _flag = false):
	pass
