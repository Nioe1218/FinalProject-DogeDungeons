extends Node2D

export var mainGameScene: PackedScene



func _on_Button_pressed():
	get_tree().change_scene("res://Scene/Level1.tscn")



func _on_Button3_pressed():
	get_tree().change_scene("res://Scene/Controls.tscn")


func _on_Button4_pressed():
	get_tree().change_scene("res://Scene/Credit.tscn")


func _on_Button2_pressed():
	get_tree().quit()
