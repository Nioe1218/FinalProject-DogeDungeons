extends Node2D

export var mainGameScene: PackedScene



func _on_Button_pressed():
	get_tree().change_scene("res://Scene/Level1.tscn")


func _on_Button2_pressed():
	get_tree().change_scene("res://Scene/Menu.tscn")

