extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var ScoreLabel = get_node("Score")
onready var Score = fsm.get_ref().getScore()
var fsm: WeakRef

# Called when the node enters the scene tree for the first time.
func _ready():
	if(fsm.get_ref().bossNum >= 2):
		$Score.text = "Score: " + str(Score)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	fsm.get_ref().MachineReset()
	pass # Replace with function body.
