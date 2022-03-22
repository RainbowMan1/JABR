extends Node

#class_name StateMachine
#source: https://gdscript.com/solutions/godot-state-machine/
const DEBUG = true

var mainMenu = preload("res://MainMenu/mainMenu.tscn").instance()
var levelOne = preload("res://Arena.tscn").instance()
var levelTwo = preload("res://LevelTwo/LevelTwo.tscn").instance()
var levelThree = preload("res://LevelThree/LevelThree.tscn").instance()
var gameStates = []
var history = []
var stateNum = 0
var playerHealth =  0
var levelTime = 0
var curNode: Object
func _ready():
	print_debug("Getting machine ready")
	#gameStates.append(preload("res://State1.tscn"))
	# Set the initial state to the first child node
	gameStates.append(mainMenu)
	gameStates.append(levelOne)
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
	get_tree().get_root().remove_child(curNode)
	stateNum-=1
	if history.size() > 0:
		curNode = history.pop_back()
		_enter_state()
		
func next():
	print_debug("Returning to next state: " + curNode.name)
	get_tree().get_root().remove_child(curNode)
	stateNum +=1
	change_to(stateNum)


func _enter_state():
	
	if DEBUG:
		print_debug("Entering state: ", curNode.name)
	# Give the new state a reference to it's state machine i.e. this one
	curNode.fsm = weakref(self)
	get_tree().get_root().add_child(curNode)

func updateGameState():
	print_debug("Game state will be updated from a different place")


func scoreData(time, health): 
	playerHealth = health
	levelTime = time
	
func calcScore():
	return playerHealth/levelTime
## Route Game Loop function calls to
## current state handler method if it exists
func _process(delta):
	if $"BackgroundMusic".playing == false:
		$"BackgroundMusic".play()
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
