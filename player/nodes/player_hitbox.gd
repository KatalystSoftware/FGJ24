class_name PlayerHitbox
extends Hitbox

@export var experience: Experience


func damage(amount: int = 1) -> void:
	if not health:
		push_warning("Unconnected hitbox")
		return

	health.take_damage(amount)


func collect() -> void:
	if not experience:
		push_warning("Unconnected hitbox")
		return

	experience.collect_experience()
