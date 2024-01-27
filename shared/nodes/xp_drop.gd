class_name XPDrop
extends Area2D


func _physics_process(_delta):
	$CollisionShape2D.shape.size = Vector2(PlayerStats.pickup_range, PlayerStats.pickup_range)


func _on_area_entered(area: Area2D):
	if area is PlayerHitbox:
		var hitbox: PlayerHitbox = area
		hitbox.collect()

	queue_free()
