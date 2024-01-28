class_name Player
extends CharacterBody2D

@export var ShotScene = preload("res://player/scenes/player_shot.tscn")
@export var SwooshAudioStream = preload("res://assets/swoosh.mp3")
@export var LaughAudioStream = preload("res://assets/laugh.mp3")


func _ready():
	DebugUI.get_node("Stats").add_property(self, "transform:origin")
	DebugUI.get_node("Stats").add_property(
		$Cooldown, "time_left", DebugProperty.DisplayOption.ROUNDED
	)
	DebugUI.get_node("Stats").add_property($Health, "count")


func _physics_process(_delta):
	if Globals.is_dying:
		return

	if $RegenCooldown.is_stopped():
		var new_health = $Health.count + PlayerStats.max_health * PlayerStats.regen_rate
		if new_health > PlayerStats.max_health:
			new_health = PlayerStats.max_health
		$Health.count = new_health
		$RegenCooldown.start()

	var movement_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	velocity = movement_direction.normalized() * PlayerStats.movement_speed

	if velocity == Vector2.ZERO:
		$AnimatedSprite2D.play("idle")
	else:
		var moving_to_left = velocity.x < 0
		$AnimatedSprite2D.flip_h = moving_to_left
		$AnimatedSprite2D.play("walk")

	move_and_slide()

	if $Cooldown.is_stopped():
		shoot_nearest_enemy()
		play_swhoosh_sound()
		$Cooldown.wait_time = PlayerStats.shot_cooldown
		$Cooldown.start()


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
		shot.get_node("Lifetime").wait_time = PlayerStats.shot_lifetime


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


func play_swhoosh_sound():
	var audio_player = AudioStreamPlayer.new()
	audio_player.autoplay = true
	audio_player.stream = SwooshAudioStream
	audio_player.finished.connect(func(): remove_child(audio_player))
	add_child(audio_player)
	
func play_laugh_sound():
	var audio_player = AudioStreamPlayer.new()
	audio_player.autoplay = true
	audio_player.stream = LaughAudioStream
	audio_player.finished.connect(func(): remove_child(audio_player))
	add_child(audio_player)


func cleanup_sound(player: AudioStreamPlayer):
	remove_child(player)
	player.queue_free()


func _on_health_died():
	Globals.is_dying = true
	$AnimatedSprite2D.play("death")
	play_laugh_sound()
	$AnimatedSprite2D.animation_finished.connect(_on_death_animation_finished)


func _on_death_animation_finished():
	$DeathUI.visible = true
	$AnimatedSprite2D.animation_finished.disconnect(_on_death_animation_finished)


func _on_experience_level_up():
	$LevelUpUI.show_options()
