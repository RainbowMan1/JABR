extends Node

#class_name StateMachine
#source: https://gdscript.com/solutions/godot-state-machine/
const DEBUG = true

var state: Object
var stateOne = preload("res://States/State1.tscn").instance()
var stateTwo = preload("res://States/State2.tscn").instance()
var gameStates = []
var history = []
var stateNum = 0

var curNode: Object
func _ready():
	print_debug("Getting machine ready")
	#gameStates.append(preload("res://State1.tscn"))
	# Set the initial state to the first child node
	gameStates.append(stateOne)
	gameStates.append(stateTwo)
	curNode = gameStates[0]
	#state = gameStates[0]
	# Allow for all nodes to be ready before calling _enter_state
	call_deferred("_enter_state")


func change_to(Num):
	
	history.append(curNode)
	curNode = gameStates[Num]
	print_debug("Changing scene to: " + curNode.name)
	
	
	_enter_state()


func back():
	print_debug("Returning to previous state: " + curNode.name)
	if history.size() > 0:
		curNode = history.pop_back()
		_enter_state()


func _enter_state():
	
	if DEBUG:
		print("Entering state: ", curNode.name)
	# Give the new state a reference to it's state machine i.e. this one
	curNode.fsm = self
	curNode.get_child(0).rect_global_position = Vector2(0,0)
	curNode.enter()
	get_tree().change_scene("res://States/"+ curNode.name +".tscn")


## Route Game Loop function calls to
## current state handler method if it exists
#func _process(delta):
#	if state.has_method("process"):
#		state.process(delta)
#
#
#func _physics_process(delta):
#	if state.has_method("physics_process"):
#		state.physics_process(delta)
#
#
#func _input(event):
#	if state.has_method("input"):
#		state.input(event)
#
#func _unhandled_input(event):
#	if state.has_method("unhandled_input"):
#		state.unhandled_input(event)
#
#
#func _unhandled_key_input(event):
#	if state.has_method("unhandled_key_input"):
#		state.unhandled_key_input(event)
#
#
#func _notification(what):
#	if state and state.has_method("notification"):
#			state.notification(what)
