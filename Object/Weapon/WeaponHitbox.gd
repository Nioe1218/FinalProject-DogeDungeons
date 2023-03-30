extends Hitbox


func _on_Hitbox_area_entered(area:Area2D):
	area.queue_free()
