extends Area2D


onready var collision_shape: CollisionShape2D = get_node("CollisionShape2D")


func _on_Black_Hole_body_entered(_body:KinematicBody2D):
	collision_shape.set_deferred("disabled", true)
	Changescence.start_transition_to("res://Scene/Level1.tscn")
	_body.emit_signal("level_changed")

