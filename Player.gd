extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	var direction: Vector2
	$PlayerArrowRectangle.rotation += $PlayerArrowRectangle.position.angle_to_point(get_local_mouse_position())
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	#handling diagonal movement 
	if (abs(direction.x) == 1 and abs(direction.y) == 1):
		direction = direction.normalized()
