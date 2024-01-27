class_name Player
extends CharacterBody2D

@export var ShotScene = preload("res://player/scenes/player_shot.tscn")
@export var shot_speed = 600.0
@export var movement_speed = 300.0


func _ready():
	DebugUI.get_node("Stats").add_property(self, "transform:origin")
	DebugUI.get_node("Stats").add_property(
		$Cooldown, "time_left", DebugProperty.DisplayOption.ROUNDED
	)


func _physics_process(_delta):
	var movement_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	velocity = movement_direction.normalized() * movement_speed

	move_and_slide()

	if $Cooldown.is_stopped():
		shoot_nearest_enemy()


func shoot_nearest_enemy():
	var closest_enemy = get_closest_enemy()
	if not closest_enemy:
		return

	var direction = closest_enemy.global_position - position
	var shot: Shot = ShotScene.instantiate()
	get_tree().get_root().add_child(shot)
	shot.shot_speed = shot_speed
	shot.position = position
	shot.rotation = direction.angle()
	$Cooldown.start()


func get_closest_enemy() -> CharacterBody2D:
	var enemies = get_tree().get_nodes_in_group("Enemy")
	if len(enemies) == 0:
		return

	var nearest_enemy = enemies[0]
	for enemy in enemies:
		var distance_to_enemy = enemy.global_position.distance_to(self.global_position)
		var distance_to_nearest = nearest_enemy.global_position.distance_to(self.global_position)
		if distance_to_enemy < distance_to_nearest:
			nearest_enemy = enemy

	return nearest_enemy


func _on_health_died():
	queue_free()
