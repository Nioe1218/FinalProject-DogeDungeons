extends Hitbox

var enemy_exited: bool = false

var direction: Vector2 = Vector2.ZERO
var ball_speed: int = 0


func launch(initial_position: Vector2, dir: Vector2, speed: int) -> void:
	position = initial_position
	direction = dir
	knockback_direction = dir
	ball_speed = speed
	
	rotation += dir.angle() + PI/4
	
	
func _physics_process(delta: float) -> void:
	position += direction * ball_speed * delta




func _collide(body: KinematicBody2D) -> void:
	if enemy_exited:
		if body != null:
			body.take_damage(damage, knockback_direction, knockback_force)
		queue_free()


func _on_Fireball_body_exited(_body: KinematicBody):
	if not enemy_exited:
		enemy_exited = true
		set_collision_mask_bit(0, true)
		set_collision_mask_bit(1, true)
		set_collision_mask_bit(2, true)
		set_collision_mask_bit(3, true)
