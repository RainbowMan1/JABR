extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var ScoreLabel = get_node("Score")
onready var Score = fsm.get_ref().getScore()
var fsm: WeakRef

# Called when the node enters the scene tree for the first time.
func _ready():
	if fsm.get_ref().playerLost:
		$GameOverLabel.text = "You Lost"
	else:
		$GameOverLabel.text = "You Win!"
	$Score.text = "Score: " + str(int(Score))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	fsm.get_ref().MachineReset()
	pass # Replace with function body.
