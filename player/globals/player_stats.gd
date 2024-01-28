extends Node

const BASE_MAX_HEALTH = 25.0
const BASE_REGEN_RATE = 0.02
const BASE_MOVEMENT_SPEED = 300.0
const BASE_EXPERIENCE_MULTIPLIER = 1.0
const BASE_PICKUP_RANGE = 500.0
const BASE_SHOT_AMOUNT = 1
const BASE_SHOT_DAMAGE = 1.0
const BASE_SHOT_COOLDOWN = 0.25
const BASE_SHOT_SPEED = 500.0
const BASE_SHOT_LIFETIME = 1.0
const BASE_SHOT_SPREAD = PI / 2.0

var max_health = BASE_MAX_HEALTH
var regen_rate = BASE_REGEN_RATE
var movement_speed = BASE_MOVEMENT_SPEED
var experience_multiplier = BASE_EXPERIENCE_MULTIPLIER
var pickup_range = BASE_PICKUP_RANGE

var shot_amount = BASE_SHOT_AMOUNT
var shot_damage = BASE_SHOT_DAMAGE
var shot_cooldown = BASE_SHOT_COOLDOWN
var shot_speed = BASE_SHOT_SPEED
var shot_lifetime = BASE_SHOT_LIFETIME
var shot_spread = BASE_SHOT_SPREAD


func _init():
	DebugUI.get_node("Stats").add_property(self, "max_health")
	DebugUI.get_node("Stats").add_property(self, "regen_rate")
	DebugUI.get_node("Stats").add_property(self, "movement_speed")
	DebugUI.get_node("Stats").add_property(self, "experience_multiplier")
	DebugUI.get_node("Stats").add_property(self, "pickup_range")
	DebugUI.get_node("Stats").add_property(self, "shot_amount")
	DebugUI.get_node("Stats").add_property(self, "shot_damage")
	DebugUI.get_node("Stats").add_property(self, "shot_cooldown")
	DebugUI.get_node("Stats").add_property(self, "shot_speed")
	DebugUI.get_node("Stats").add_property(self, "shot_lifetime")
	DebugUI.get_node("Stats").add_property(self, "shot_spread")
