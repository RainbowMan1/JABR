extends Node

onready var fsm = get_node("/root/StateMachine")


	
func enter():
	print("Hello from State 2!")
	
	#self.get_child(0).modulate.a = 1
	#yield(get_tree().create_timer(5.0), "timeout")
	exit()

func exit():
	
	#self.get_child(0).modulate.a = 0
	# Go back to the last state
	
	fsm.back()
