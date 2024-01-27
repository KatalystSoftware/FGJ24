class_name Enemy
extends CharacterBody2D

@export var XPDropScene = preload("res://enemies/base/xp_drop.tscn")


func _physics_process(_delta):
	move_and_slide()


func _on_health_died():
	var xp_drop: XPDrop = XPDropScene.instantiate()
	xp_drop.position = position
	get_tree().get_root().call_deferred("add_child", xp_drop)

	queue_free()
