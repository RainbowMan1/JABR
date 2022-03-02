extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed: int
var direction : Vector2
var damage: int

# Called when the node enters the scene tree for the first time.
func _ready():
	speed = 50
	damage = 1

func _physics_process(delta):
	translate(direction.normalized() * speed * delta)

func set_direction(x_new, y_new):
	direction.x = x_new
	direction.y = y_new


func _on_Projectile_area_entered(area):
	if(area.get_parent().name != "Boss"):
		queue_free()