class_name DamageArea
extends Area2D


func _on_area_entered(area: Area2D):
	if area is Hitbox:
		var hitbox: Hitbox = area
		hitbox.damage()

	queue_free()


func _on_lifetime_timeout():
	queue_free()
