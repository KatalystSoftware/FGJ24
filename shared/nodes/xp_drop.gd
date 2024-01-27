class_name XPDrop
extends Area2D


func _on_area_entered(area: Area2D):
	if area is PlayerHitbox:
		var hitbox: PlayerHitbox = area
		hitbox.collect()

	queue_free()
