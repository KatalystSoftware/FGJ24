class_name BaseEnemy
extends CharacterBody2D


func _on_health_died():
	queue_free()
