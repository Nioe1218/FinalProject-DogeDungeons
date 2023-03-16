extends CanvasLayer

const MIN_health:int =1

var max_hp:int =5


onready var player:KinematicBody2D=get_parent().get_node("Player")
onready var health_bar:TextureProgress = get_node("Healthbar")
onready var health_bar_tween: Tween = get_node("Healthbar/Tween")

func _ready():
	max_hp = player.hp
	_update_health_bar(100)
	
func _update_health_bar(new_value:int):#health bar
	var __ = health_bar_tween.interpolate_property(health_bar,"value",health_bar.value,new_value,0.5 , Tween.TRANS_QUINT,Tween.EASE_OUT)
	__ = health_bar_tween.start()
	
func _on_Player_hp_changed(new_hp:int)->void:
	var new_health: int = int((100-MIN_health)*float(new_hp)/max_hp)+MIN_health
	_update_health_bar(new_health)
