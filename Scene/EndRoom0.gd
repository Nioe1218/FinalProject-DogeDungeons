extends Node2D




func _on_Player_Detector_body_entered(_body):
	get_tree().reload_current_scene()
