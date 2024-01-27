class_name PlayerHitbox
extends Hitbox

@export var experience: Experience


func collect() -> void:
	if not experience:
		push_warning("Unconnected hitbox")
		return

	experience.collect_experience()
