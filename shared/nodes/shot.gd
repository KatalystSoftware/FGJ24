class_name Shot
extends Area2D

@export var shot_speed = 300.0
@export var shot_damage = 10.0


func _physics_process(delta):
	translate(Vector2.from_angle(rotation) * delta * shot_speed)


func _on_lifetime_timeout():
	queue_free()
