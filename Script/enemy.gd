extends Character
class_name Enemy

onready var player: KinematicBody2D =  $"../Player"
onready var navigation : Navigation2D =  $"../Navigation2D"
onready var path_timer: Timer = get_node("PatchTimer")

var path: PoolVector2Array


func chase()->void:
	if path:
		var vector_to_next_point:Vector2 = path[0]- global_position
		var distance_to_next_point:float = vector_to_next_point.length()
		if distance_to_next_point <2:
			path.remove(0)
			if not path:
				return
		mov_direction = vector_to_next_point
		
		if vector_to_next_point.x>0:
			animated_sprite.flip_h = false
		elif vector_to_next_point.x<0:
			animated_sprite.flip_h = true

func _on_PatchTimer_timeout()-> void:
	if is_instance_valid(player):
		path = navigation.get_simple_path(global_position,player.position)
	else:
		path_timer.stop()
		path = []
		mov_direction = Vector2.ZERO
