extends CharacterBody2D

@export var movement_speed = 300.0


func _physics_process(_delta):
	var movement_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	velocity = movement_direction.normalized() * movement_speed

	move_and_slide()
