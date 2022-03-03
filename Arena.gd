extends Node2D

onready var fsm = $StateMachine
var clock = 0 
var time_multi = 1.0 
var paused = false
onready var clockText = get_node("ClockText")
onready var playerHealth = get_node("PlayerBase").health
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	pass # Replace with function body.


func updateGameState():
	fsm.get_ref().updateGameState()
	#fsm.scoreData(clock, playerHealth)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Updates clock text every second
	clock += delta * time_multi 
	clockText.text = "Time: " + str(int(clock)) + "sec"
	
	pass
