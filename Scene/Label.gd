extends Label

var num_levels = 1
onready var player: KinematicBody2D =  get_tree().current_scene.get_node("Player")
onready var level_label = $Label

func _ready():
	_restore_previous_state()
	level_label.set_text(str(num_levels))
	var _player_path = player
	_player_path.connect("level_changed", self, "pass_level")

	
func _restore_previous_state()->void:#save the hp data for next level
	self.num_levels = Savedata.num_levels

func pass_level():
	Savedata.num_levels += 1
	level_label.set_text(str(num_levels))
