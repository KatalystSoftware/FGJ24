class_name SpinningSprite2D
extends Sprite2D

@export var rotation_speed = 10.0


func _physics_process(delta):
	rotation += delta * rotation_speed
