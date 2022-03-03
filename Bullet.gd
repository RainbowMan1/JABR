extends Area2D

var damage = 10
var direction : Vector2
var speed = 100
var Player


func _process(delta):#moves in a position every second
	position = position + speed * delta * direction

	

func _on_Bullet_area_entered(area):#what happens when the bullet enters an area
	if(area.name == "HurtBox"):
		queue_free()


func _on_Bullet_body_entered(body):#what happens when a bullet hits the body
	if body.name == "Player":
		return
	direction = Vector2.ZERO
