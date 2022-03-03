extends KinematicBody2D


const max_health = 100
const COOLDOWN_WAIT_TIME = .2

var health = 100
var damage = 10
var speed = 100

var block = false
var dodge = false
var block_cooldown = 5
var atk_cooldown = 0

var bullet = preload("res://Bullet.tscn")


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
	if(block_cooldown <= 0):
		if(Input.get_action_strength("block")):
			block()
		if(Input.get_action_strength("dodge")):
			dodge()
	else:
		block_cooldown -= delta
	if(Input.get_action_strength("shoot")):
		if(atk_cooldown <= 0):
			shoot()
			atk_cooldown = COOLDOWN_WAIT_TIME
		else:
			atk_cooldown -= delta

func block():#has the player block
	if(block_cooldown):
		print("Block")
		block = true
		block_cooldown = 5
	else:
		block = false

func dodge():#has the player dodge
	if(block_cooldown):
		print("Dodge")
		dodge = true
		block_cooldown = 5
	else:
		dodge = false

func shoot():
	var b = bullet.instance()
	b.Player = self
	b.damage = damage
	get_parent().add_child(b)
	b.direction = (get_global_mouse_position() - position).normalized()
	b.transform = $ProjectileLauncher.global_transform #shoots the projectile from the position of Projectile Launcher

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
		health -= area.damage

