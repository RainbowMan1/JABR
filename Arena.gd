extends Node2D

var fsm: WeakRef
var clock = 0 
var time_multi = 1.0 
var paused = false
var killed = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func updateBossHealth(val):
	$BossHealthBar.value = val

func updateGameState():
	fsm.get_ref().updateGameState()
	#fsm.scoreData(clock, playerHealth)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Updates clock text every second
	clock += delta * time_multi 
	#print_debug("boss health" + str(bossHealth))
	#print(self.get_child(2))
	
		
		
	
	pass


func _on_Boss_tree_exiting():
	print_debug("Boss Defeated")
	paused = true
	pass # Replace with function body.


func _on_Boss2_tree_exiting():
	print_debug("Boss Defeated")
	#scoreText.text = "Score: " + str(playerHealth/clock)
	paused = true
	
	print("Before FSM reference")
	print(fsm.get_ref().curNode.name)
	print("After FSM reference")
	pass # Replace with function body.


func _on_PlayerBase_tree_exited():
	if(killed):
		print_debug("Player Killed")
		fsm.get_ref().playerLost()
	
	 # Replace with function body.


func _on_Boss2_tree_exited():
	if (get_node("PlayerBase") != null):
		fsm.get_ref().scoreData(clock, get_node("PlayerBase").health)
		fsm.get_ref().next() # Replace with function body.
