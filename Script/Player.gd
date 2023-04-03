extends Character

enum {UP,DOWN}
var current_weapon:Node2D
onready var weapons:Node2D = get_node("Weapon")




func _ready():
	current_weapon = weapons.get_child(0)
	_restore_previous_state()
	
func _restore_previous_state()->void:#save the hp data for next level
	self.hp = Savedata.hp

func _process(_delta:float)-> void:# player will face to the mouse position
	var mouse_direction:Vector2 = (get_global_mouse_position()-global_position).normalized()
	
	if mouse_direction.x<0 and animated_sprite.flip_h:
		animated_sprite.flip_h = false
	elif mouse_direction.x>0 and not animated_sprite.flip_h:
		animated_sprite.flip_h = true
		
	current_weapon.move(mouse_direction)
		


	
func get_input()-> void:#player input
	mov_direction=Vector2.ZERO
	if Input.is_action_pressed("ui_down"):
		mov_direction += Vector2.DOWN
	if Input.is_action_pressed("ui_up"):
		mov_direction += Vector2.UP
	if Input.is_action_pressed("ui_left"):
		mov_direction += Vector2.LEFT
	if Input.is_action_pressed("ui_right"):
		mov_direction += Vector2.RIGHT
	if not current_weapon.is_busy():
		if Input.is_action_just_released("ui_previous_weapon"):
			_switch_weapon(UP)
		elif Input.is_action_just_released("ui_next_weapon"):
			_switch_weapon(DOWN)
	current_weapon.get_input()
		
func cancel_attack() -> void:
	current_weapon.cancel_attack()
		
func switch_camrea()->void:
	var main_scene_camera: Camera2D= get_parent().get_node("Camera2D")
	main_scene_camera.position = position
	main_scene_camera.current = true
	get_node("Camera2D").current = false
	
func _switch_weapon(direction: int) -> void:#change the weapon
	var index: int = current_weapon.get_index()
	if direction == UP:
		index -= 1
		if index < 0:
			index = weapons.get_child_count() - 1
	else:
		index += 1
		if index > weapons.get_child_count() - 1:
			index = 0
			
	current_weapon.hide()
	current_weapon = weapons.get_child(index)
	current_weapon.show()

