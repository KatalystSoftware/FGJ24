class_name Hitbox
extends Area2D

@export var health: Health


func damage() -> void:
	if not health:
		push_warning("Unconnected hitbox")
		return

	health.take_damage()
