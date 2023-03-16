extends Character

onready var bone:Node2D = get_node("Bone")
onready var bone_hitbox: Area2D = get_node("Bone/Node2D/Sprite/Hitbox")
onready var bone_animation_player:AnimationPlayer = bone.get_node("BoneAnimationPlayer")
func _process(_delta:float)-> void:
	var mouse_direction:Vector2 = (get_global_mouse_position()-global_position).normalized()
	
	if mouse_direction.x<0 and animated_sprite.flip_h:
		animated_sprite.flip_h = false
	elif mouse_direction.x>0 and not animated_sprite.flip_h:
		animated_sprite.flip_h = true
		
	bone.rotation = mouse_direction.angle()
	bone_hitbox.knockback_direction = mouse_direction
	if bone.scale.y ==1 and mouse_direction.x>0:
		bone.scale.y = -1
	elif bone.scale.y ==-1 and mouse_direction.x <0:
		bone.scale.y =1
	
func get_input()-> void:
	mov_direction=Vector2.ZERO
	if Input.is_action_pressed("ui_down"):
		mov_direction += Vector2.DOWN
	if Input.is_action_pressed("ui_up"):
		mov_direction += Vector2.UP
	if Input.is_action_pressed("ui_left"):
		mov_direction += Vector2.LEFT
	if Input.is_action_pressed("ui_right"):
		mov_direction += Vector2.RIGHT
	if Input.is_action_just_pressed("ui_attack") and not bone_animation_player.is_playing():
		bone_animation_player.play("attack")
		