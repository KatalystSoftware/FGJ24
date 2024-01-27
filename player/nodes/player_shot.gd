class_name PlayerShot
extends Shot


func _on_area_entered(area: Area2D):
	if area is Hitbox:
		var hitbox: Hitbox = area
		hitbox.damage(PlayerStats.shot_damage)

	queue_free()
