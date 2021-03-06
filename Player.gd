extends KinematicBody2D


const max_health = 100
const COOLDOWN_WAIT_TIME = .5

var health = 100
var damage = 10
var speed = 100
var facing_direction = 0

var block = false
var dodge = false
var block_cooldown = 5
var atk_cooldown = 0
var poisoned = false
var killed = false

var bullet = preload("res://Bullet.tscn")


func _physics_process(delta):#physics process of every second
	if health <= 0:
		die()
	var direction: Vector2
	#$PlayerArrowRectangle.rotation += $PlayerArrowRectangle.position.angle_to_point(get_local_mouse_position())
	if(!block):
		direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	#handling diagonal movement 
	if (abs(direction.x) == 1 and abs(direction.y) == 1):
		direction = direction.normalized()
	
	$PlayerSprite.look_at(get_global_mouse_position())
	
	var movement = speed * direction * delta
	move_and_collide(movement)
	if(block_cooldown <= 0):
		if(Input.get_action_strength("block")):
			block()
		if(Input.get_action_strength("dodge")):
			dodge()
	else:
		block_cooldown -= delta
	
	if(Input.get_action_strength("shoot")): #SHOOTING LOGIC
		if(atk_cooldown <= 0):
			shoot()
			atk_cooldown = COOLDOWN_WAIT_TIME
	atk_cooldown -= delta
	
	if(poisoned):
		$poison_text.show()
		#setTimer("poisoned", 1)
		#poisoned = false
		#print("Health is", health)
	else:
		$poison_text.hide()

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
	$shoot.play()
	var b = bullet.instance()
	b.Player = self
	b.damage = damage
	get_parent().add_child(b)
	print(b.name)
	b.direction = (get_global_mouse_position() - position).normalized()
	b.transform = $PlayerSprite/ProjectileLauncher.global_transform #shoots the projectile from the position of Projectile Launcher

func setTimer(spawn_func, spawn_time) -> Timer:
	#creates a timer based on the function given in the first parameter and time given in second parameter
	var timer = Timer.new()
	add_child (timer)
	timer.set_wait_time(spawn_time)
	timer.one_shot = true
	timer.connect("timeout", self, spawn_func) 
	timer.start()
	return timer

func _on_PlayerHurtBox_area_entered(area):
	if block or dodge:
		health -= 0
	else:
		if(area.is_in_group("boss_attack")):
			health -= area.damage
			$scream.play()
			$HealthBar.value = health
		if(area.is_in_group("poison_projectile")):
			poisoned = true
			setTimer("poisoned", 1)
			#poisoned = false
			print("Health is", health)
			print("poisoned is", poisoned)
			$poisontimer.start()

func poisoned():
	if (health - 4 <= 0):
		health = 1
	else:
		health-= 4
	$HealthBar.value = health
	if(poisoned):
		setTimer("poisoned", 1)
		pass
	
func cure():
	poisoned = false
	
func die():
	get_parent().killed = true
	queue_free()


func _on_poisontimer_timeout():
	cure() # Replace with function body.
