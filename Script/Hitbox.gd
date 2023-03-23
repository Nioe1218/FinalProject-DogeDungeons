extends Area2D
class_name Hitbox

export(int) var damage:int =1
var knockback_direction: Vector2=Vector2.ZERO
export(int) var knockback_force: int = 250
onready var collision_shape:CollisionShape2D = get_child(0)

func _init():
	var __ = connect("body_entered",self,"_on_body_entered")
	
func _ready():#make sure the hitbox has a collision shape
	assert(collision_shape!= null)
	
	#when a body enters the area, call the function take damage of the body withe the variables
func _on_body_entered(body:PhysicsBody2D):
	_collide(body)

func _collide(body: KinematicBody2D) -> void:
	if body == null or not body.has_method("take_damage"):
		queue_free()
	else:
		body.take_damage(damage, knockback_direction, knockback_force)
