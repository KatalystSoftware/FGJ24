class_name Player
extends CharacterBody2D

@export var ShotScene = preload("res://player/scenes/player_shot.tscn")


func _ready():
	DebugUI.get_node("Stats").add_property(self, "transform:origin")
	DebugUI.get_node("Stats").add_property(
		$Cooldown, "time_left", DebugProperty.DisplayOption.ROUNDED
	)


func _physics_process(_delta):
	var movement_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	velocity = movement_direction.normalized() * PlayerStats.movement_speed

	move_and_slide()

	if $Cooldown.is_stopped():
		shoot_nearest_enemy()


func shoot_nearest_enemy():
	var closest_enemy = get_closest_enemy()
	if not closest_enemy:
		return

	var spread = PlayerStats.shot_spread
	var amount = PlayerStats.shot_amount
	for n in range(amount):
		var rotation_offset = spread * n / amount - spread / 2.0 + spread / (2.0 * amount)
		var direction = position.direction_to(closest_enemy.global_position)
		var shot: PlayerShot = ShotScene.instantiate()
		shot.shot_damage = PlayerStats.shot_damage
		shot.shot_speed = PlayerStats.shot_speed
		get_tree().get_root().add_child(shot)
		shot.position = position
		shot.rotation = direction.angle() + rotation_offset
		$Cooldown.wait_time = PlayerStats.shot_cooldown
		shot.get_node("Lifetime").wait_time = PlayerStats.shot_lifetime
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


func _on_experience_level_up():
	$LevelUpUI.show_options()
