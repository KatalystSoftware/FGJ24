class_name XPDrop
extends Area2D

@export var amount = 1.0

func _physics_process(_delta):
	$CollisionShape2D.shape.size = Vector2(PlayerStats.pickup_range, PlayerStats.pickup_range)


func _on_area_entered(area: Area2D):
	if area is PlayerHitbox:
		var hitbox: PlayerHitbox = area
		hitbox.collect(amount)

	queue_free()
