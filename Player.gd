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


func _physics_process(delta):#physics process of every second
	var direction: Vector2
	#$PlayerArrowRectangle.rotation += $PlayerArrowRectangle.position.angle_to_point(get_local_mouse_position())
	if(!block):
		direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	#handling diagonal movement 
	if (abs(direction.x) == 1 and abs(direction.y) == 1):
		direction = direction.normalized()
	
	var movement = speed * direction * delta
	move_and_collide(movement)
		
func get_input(delta):#gets the input every second
	if(block_cooldown <= 0):
		if(Input.get_action_strength("block")):
			print("Block")
			setTimer(block,1)
			block = false
			block_cooldown = 5
		if(Input.get_action_strength("dodge")):
			print("Dodge")
			setTimer(dodge,4)
			dodge = false
			block_cooldown = 5
	else:
		block_cooldown -= delta

func block():#sets block to true
	block = true

func dodge():#sets dodge to true
	dodge = true#need to make it so that moves in the direction of previously pressed keys

func setTimer(spawn_func, spawn_time) -> Timer:
	#creates a timer based on the function given in the first parameter and time given in second parameter
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
	

