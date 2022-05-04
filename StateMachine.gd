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
var controlScreen = preload("res://transitionScreens/ControlsScreen.tscn")
var gameStates = []
var history = []
var stateNum = 0
var playerHealth =  0
var bossNum = 0
var playerLost = false
var curNode: Object

var levelScores = []
var levelTime = []
var lastLevelScore
var lastLevelTime
var showControl

func should_Load_tutorial():
	var save_game = File.new()
	if not save_game.file_exists("user://savestore.save"):
		return true
	save_game.open("user://savestore.save", File.READ)
	var node_data = parse_json(save_game.get_line())
	return node_data["showTutorial"]

func _ready():
	print_debug("Getting machine ready")
	
	showControl = should_Load_tutorial()
	#gameStates.append(preload("res://State1.tscn"))
	# Set the initial state to the first child node
	gameStates.append(mainMenu.instance())
	if (showControl):
		gameStates.append(controlScreen.instance())
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

func playerLost():
	playerLost = true
	if(is_instance_valid(curNode)):
		get_tree().get_root().remove_child(curNode)
	change_to(gameStates.size()-1)

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
			gameStates[Num].get_node("Label").text = "Fly Trap"
			print_debug("boss name set to plant")
		bossNum += 1
		
	#Return canvas layer to foreground so it can be seen
	$TransitionLayer.transition(1)
	yield(get_tree().create_timer(0.5), "timeout")
	_enter_state()
	
	#$TransitionLayer.set_layer(1)


func back():
	print_debug("Returning to previous state: " + curNode.name)
	if(is_instance_valid(curNode)):
		get_tree().get_root().remove_child(curNode)
	stateNum-=1
	if history.size() > 0:
		curNode = history.pop_back()
		_enter_state()
		
func next():
	
	
	print_debug("Returning to next state: " + curNode.name)
	if(is_instance_valid(curNode)):
		get_tree().get_root().remove_child(curNode)
	#curNode.free()
	stateNum +=1
	#if(stateNum >= 11):z
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
	lastLevelScore = calcScore(health, time)
	levelScores.append(calcScore(health, time))
	lastLevelTime = time
	levelTime.append(lastLevelTime)
	
	
func calcScore(health, lvltime):
	if(lvltime > 0):
		return (health/lvltime)*100
	else:
		print_debug("Level has no time")
		return 0
		
func getScore(): 
	var total = 0
	print(levelScores)
	for i in levelScores:
		total += i
	return total
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
	if(is_instance_valid(curNode)):
		get_tree().get_root().remove_child(curNode)
	if history.size() > 0:
		history.clear()
		
		mainMenu = load("res://MainMenu/mainMenu.tscn")
		levelOne = load("res://Arena.tscn")
		levelTwo = load("res://LevelTwo/LevelTwo.tscn")
		levelThree = load("res://LevelThree/LevelThree.tscn")
		scoreScreen = load("res://transitionScreens/ScoreScreen.tscn")
		bossTitle = load("res://transitionScreens/TitleScreen.tscn")
		gameOver = load("res://transitionScreens/GameOverScreen.tscn")
		gameStates.clear()
		# Set the initial state to the first child node
		gameStates.append(mainMenu.instance())
		if (showControl):
			gameStates.append(controlScreen.instance())
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
		levelScores = []
		levelTime = []
		playerLost = false
		
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






