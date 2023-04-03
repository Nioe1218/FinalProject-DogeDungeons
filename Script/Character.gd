extends KinematicBody2D
class_name Character
signal level_changed(new_level)
export(int) var hp: int = 2 setget set_hp
export(int) var max_hp :int =10
 #store the health for the characters
signal hp_changed(new_hp)
export(int) var max_speed: int = 200 #speed and accerlation for the characters
export(int) var accerelation:int = 50
export(bool) var flying: bool = false
onready var state_machine:Node = get_node("FiniteStateMachine")
#change the states when take the damage

onready var animation_player:AnimationPlayer = get_node("AnimationPlayer")
onready var animated_sprite: AnimatedSprite = get_node("AnimatedSprite")
const Friction:float = 0.1
var mov_direction: Vector2 = Vector2.ZERO
var velocity:Vector2 = Vector2.ZERO

func _physics_process(_delta:float)->void:
	# move the character using move and slide with the velocity and apply the friction using lerp
	velocity = move_and_slide(velocity)
	velocity= lerp(velocity,Vector2.ZERO,Friction)
func move()->void:#move the character
	mov_direction = mov_direction.normalized()
	velocity += mov_direction*accerelation
	velocity = velocity.clamped(max_speed)

#all the characters in this class will take damage
func take_damage(dam:int,dir:Vector2,force:int):
	
	self.hp -= dam #hp decrease
	
	if name == "Player":
		Savedata.hp = hp
	
	
	if hp >0:
		state_machine.set_state(state_machine.states.hurt)
		velocity += dir*force
	else:
		state_machine.set_state(state_machine.states.dead)
		velocity += dir*force*2
			
func set_hp(new_hp:int)->void:
	hp = clamp(new_hp,0,max_hp)
	emit_signal("hp_changed",new_hp)
