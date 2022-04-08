extends Node

#class_name StateMachine
#source: https://gdscript.com/solutions/godot-state-machine/
const DEBUG = true

var mainMenu = preload("res://MainMenu/mainMenu.tscn")
var levelOne = preload("res://Arena.tscn")
var levelTwo = preload("res://LevelTwo/LevelTwo.tscn")
var levelThree = preload("res://LevelThree/LevelThree.tscn")
var scoreScreen = preload("res://transitionScreens/ScoreScreen.tscn")
var bossTitle = preload("res://transitionScreens/TitleScreen.tscn")
var gameOver = preload("res://transitionScreens/GameOverScreen.tscn")
var gameStates = []
var history = []
var stateNum = 0
var playerHealth =  0
var levelTime = 0
var bossNum = 0
var curNode: Object

func _ready():
	print_debug("Getting machine ready")
	#gameStates.append(preload("res://State1.tscn"))
	# Set the initial state to the first child node
	gameStates.append(mainMenu.instance())
	#Level One
	gameStates.append(bossTitle.instance())
	gameStates.append(levelOne.instance())
	gameStates.append(scoreScreen.instance())
	#Level Two
	gameStates.append(bossTitle.instance())
	gameStates.append(levelTwo.instance())
	gameStates.append(scoreScreen.instance())
	#Level Three
	gameStates.append(bossTitle.instance())
	gameStates.append(levelThree.instance())
	gameStates.append(scoreScreen.instance())
	
	gameStates.append(gameOver.instance())
	curNode = gameStates[0]
	#state = gameStates[0]
	
	#Fades to normal when game starts and sets transition layer to the background to not block the player's input
	$TransitionLayer.transition(0)
	yield(get_tree().create_timer(0.5), "timeout")
	#$TransitionLayer.set_layer(-1)
	# Allow for all nodes to be ready before calling _enter_state
	connect("tree_exiting", self, "MachineReset")
	call_deferred("_enter_state")


func change_to(Num):
	
	history.append(curNode)
	curNode = gameStates[Num]
	#stateNum = Num
	print_debug("Changing scene to: " + curNode.name)
	if(curNode.name == "TitleScreen"):
		
		
		if(bossNum == 0):
			gameStates[Num].get_node("Label").text = "Slime"
			print_debug("boss name set to slime")
		
		elif(bossNum == 1):
			gameStates[Num].get_node("Label").text = "Fortress"
			print_debug("boss name set to fortress")
		elif(bossNum == 2):
			gameStates[Num].get_node("Label").text = "Plant"
			print_debug("boss name set to plant")
		bossNum += 1
		
	#Return canvas layer to foreground so it can be seen
	$TransitionLayer.transition(1)
	yield(get_tree().create_timer(0.5), "timeout")
	_enter_state()
	
	#$TransitionLayer.set_layer(1)


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
	#curNode.free()
	stateNum +=1
	#if(stateNum >= 11):
		#stateNum = 1
		#change_to(stateNum)
	#else:
	change_to(stateNum)


func _enter_state():
	
	if DEBUG:
		print_debug("Entering state: ", curNode.name)
	# Give the new state a reference to it's state machine i.e. this one
	curNode.fsm = weakref(self)
	#print_debug("fsm set")
	#$TransitionLayer.set_layer(1)
	#$TransitionLayer.transition(1)
	get_tree().get_root().add_child(curNode)
	if(curNode.name == "TitleScreen"):
		curNode.endScene()
	if DEBUG:
		print_debug("Entered state: ", curNode.name)
		print_debug("scene set")

func updateGameState():
	print_debug("Game state will be updated from a different place")


func scoreData(time, health): 
	playerHealth = health
	levelTime = time
	
	
func calcScore():
	if(levelTime > 0):
		return playerHealth/levelTime
	else:
		print_debug("Level has not time")
		return 0
## Route Game Loop function calls to
## current state handler method if it exists
func _process(delta):
	if $"BackgroundMusic".playing == false:
		$"BackgroundMusic".play()
		
	#if(is_instance_valid($Player)):
		#if($Player.health <= 0):
			#print_debug("Player is dead")
			#MachineReset()

func MachineReset():
	#print("Reseting game... returning to main menu...")
	print_debug("Returning to previous state: " + curNode.name)
	
	#stateNum-= stateNum - 1
	#change_to(0)
	get_tree().get_root().remove_child(curNode)
	if history.size() > 0:
		history.clear()
		
		mainMenu = preload("res://MainMenu/mainMenu.tscn")
		levelOne = preload("res://Arena.tscn")
		levelTwo = preload("res://LevelTwo/LevelTwo.tscn")
		levelThree = preload("res://LevelThree/LevelThree.tscn")
		scoreScreen = preload("res://transitionScreens/ScoreScreen.tscn")
		bossTitle = preload("res://transitionScreens/TitleScreen.tscn")
		gameOver = preload("res://transitionScreens/GameOverScreen.tscn")
		gameStates.clear()
		# Set the initial state to the first child node
		gameStates.append(mainMenu.instance())
		#Level One
		gameStates.append(bossTitle.instance())
		gameStates.append(levelOne.instance())
		gameStates.append(scoreScreen.instance())
		#Level Two
		gameStates.append(bossTitle.instance())
		gameStates.append(levelTwo.instance())
		gameStates.append(scoreScreen.instance())
		#Level Three
		gameStates.append(bossTitle.instance())
		gameStates.append(levelThree.instance())
		gameStates.append(scoreScreen.instance())
		
		gameStates.append(gameOver.instance())
		curNode = gameStates[0]
		stateNum = 0
		bossNum = 0
		_enter_state()
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






