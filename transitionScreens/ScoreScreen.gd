extends Node2D

onready var ScoreLabel = get_node("ScoreText")
onready var TimeLabel = get_node("TimeText")
onready var nextButton = get_node("Button")
onready var fsm:WeakRef
#= get_parent().get_node("StateMachine")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var time
var score

# Called when the node enters the scene tree for the first time.
#Get time and score from state machine if it is instanced
func _ready():
	print_debug("fsm name: " + fsm.get_ref().name)
	if(is_instance_valid(fsm)):
		ScoreLabel.text = "Score: " + str(int(fsm.get_ref().lastLevelScore))
		TimeLabel.text = "Time: " + str(int(fsm.get_ref().lastLevelTime))+ " seconds"
	else: 
		print_debug("State Machine not found")
		ScoreLabel.text = "Score: 0"
		TimeLabel.text = "Time: 0" 
		# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	fsm.get_ref().next()
	pass # Replace with function body.
