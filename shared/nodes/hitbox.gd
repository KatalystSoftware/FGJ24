class_name Hitbox
extends Area2D

@export var health: Health


func damage(amount: int = 1) -> void:
	if not health:
		push_warning("Unconnected hitbox")
		return

	health.take_damage(amount)
