class_name Health
extends Node

signal died  ## Signal emitted when health falls to 0

@export var count = 5


## Called when Hitbox takes damage
func take_damage():
	count -= 1
	if count <= 0:
		died.emit()
