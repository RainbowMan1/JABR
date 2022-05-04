extends Node2D

onready var fsm:WeakRef
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Button_pressed():
	save_data_not_show($"CheckBox".is_pressed())
	fsm.get_ref().next()

func	 save_data_not_show(isShow):
	var save_game = File.new()
	save_game.open("user://savestore.save", File.WRITE)
	save_game.store_line(to_json({"showTutorial": !isShow}))
