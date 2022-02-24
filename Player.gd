extends KinematicBody2D

var health = 100
var max_health = 100
var damage = 100
var speed = 100

var block = false
var dodge = false
var block_cooldown = 5
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	var direction: Vector2
	$PlayerArrowRectangle.rotation += $PlayerArrowRectangle.position.angle_to_point(get_local_mouse_position())
	if(!block):
		direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	#handling diagonal movement 
	if (abs(direction.x) == 1 and abs(direction.y) == 1):
		direction = direction.normalized()
		
func get_input(delta):
	if(block_cooldown <= 0):
		if(Input.get_action_strength("block")):
			print_debug("Block")
			setTimer(block,1)
			block = false
			block_cooldown = 5
		if(Input.get_action_strength("dodge")):
			print_debug("Dodge")
			setTimer(dodge,4)
			dodge = false
			block_cooldown = 5
	else:
		block_cooldown -= delta

func block():
	block = true

func dodge():
	dodge = true#need to make it so that moves in the direction of previously pressed keys

func setTimer(spawn_func, spawn_time) -> Timer:
	var timer = Timer.new()
	add_child (timer)
	timer.set_wait_time(spawn_time)
	timer.connect("timeout", self, spawn_func) 
	timer.start()
	return timer

func _on_PlayerHurtBox_area_entered(area):
	if block or dodge:
		health -= 0
	else:
		health -= 25


