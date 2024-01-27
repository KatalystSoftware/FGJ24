class_name Enemy
extends CharacterBody2D


func _physics_process(_delta):
	move_and_slide()


func _on_health_died():
	queue_free()
