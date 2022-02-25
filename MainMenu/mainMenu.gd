extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$"Button Container/Play Button".grab_focus()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Play_Button_pressed():
	get_tree().change_scene('res://Arena.tscn')

func _on_Quit_Button_pressed():
	get_tree().quit()
