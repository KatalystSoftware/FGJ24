class_name Experience
extends Node

signal level_up  ## Signal emitted when leveling up

@export var level = 1
@export var experience = 0.0
@export var experience_to_level = 10.0
@export var experience_scale_ratio = 1.1


func _ready():
	DebugUI.get_node("Stats").add_property(self, "level")
	DebugUI.get_node("Stats").add_property(self, "experience")
	DebugUI.get_node("Stats").add_property(self, "experience_to_level")


func collect_experience():
	experience += 1.0 * PlayerStats.experience_multiplier
	if experience >= experience_to_level:
		level += 1
		experience = 0.0
		experience_to_level *= experience_scale_ratio
		level_up.emit()
