class_name Health
extends Node

signal died  ## Signal emitted when health falls to 0

@export var count = 5


## Called when Hitbox takes damage
func take_damage(amount: int = 1):
	count -= amount
	if count <= 0:
		died.emit()
