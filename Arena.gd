extends Node2D

var fsm: WeakRef
var clock = 0 
var time_multi = 1.0 
var paused = false
onready var clockText = get_node("ClockText")
onready var scoreText = get_node("Score")
onready var playerHealth = get_node("PlayerBase").health

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	clockText.add_color_override("font_color", Color(255, 0, 0, 1))
	scoreText.add_color_override("font_color", Color(255, 0, 0, 1))
	set_process(true)
	pass # Replace with function body.


func updateGameState():
	fsm.get_ref().updateGameState()
	#fsm.scoreData(clock, playerHealth)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Updates clock text every second
	clock += delta * time_multi 
	if not paused:
		clockText.text = "Time: " + str(int(clock)) + "sec" 
	#print_debug("boss health" + str(bossHealth))
	#print(self.get_child(2))
	
		
		
	
	pass


func _on_Boss_tree_exiting():
	print_debug("Boss Defeated")
	scoreText.text = "Score: " + str(playerHealth/clock)
	paused = true
	pass # Replace with function body.


func _on_Boss2_tree_exiting():
	print_debug("Boss Defeated")
	scoreText.text = "Score: " + str(playerHealth/clock)
	paused = true
	print("Before FSM reference")
	print(fsm.get_ref().curNode.name)
	print("After FSM reference")
	pass # Replace with function body.


func _on_PlayerBase_tree_exiting():
	print_debug("Player Killed")
	scoreText.text = "You Lost"
	paused = true
	 # Replace with function body.


func _on_Boss2_tree_exited():
	fsm.get_ref().next() # Replace with function body.
