class_name Chase
extends State

@export var enemy: CharacterBody2D
@export var move_speed := 200.0

var player: CharacterBody2D


func enter():
	player = get_tree().get_first_node_in_group("Player")


func physics_update(_delta):
	if not player or player.is_queued_for_deletion():
		push_warning("Player not found or freed!")
		return

	var direction = player.global_position - enemy.global_position
	enemy.velocity = direction.normalized() * move_speed
	# Look at looks funky with the sprites if not top-down
	# enemy.look_at(player.position)
