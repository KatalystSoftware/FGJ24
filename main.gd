extends Node2D

@export var EnemyScene = preload("res://enemies/base/base_enemy.tscn")
@export var TankyScene = preload("res://enemies/base/tanky.tscn")
@export var BossScene = preload("res://enemies/base/boss.tscn")
#Format:
#[Duration, How often do we spawn these enemies, [enemies]
var enemy_table = [
	[60, 1, [EnemyScene]],
	[60, 1, [EnemyScene, EnemyScene]],
	[60, 1, [EnemyScene, EnemyScene, EnemyScene]],
	[60, 1.5, [EnemyScene, TankyScene]],
	[60, 1, [TankyScene, TankyScene]],
	[1, 1, [BossScene]],
]

var next_wave_at = 10.0
var wave = 0


func spawn_enemies():
	if next_wave_at <= Globals.time_elapsed && wave < enemy_table.size() - 1:
		next_wave_at += enemy_table[wave][0]
		wave += 1
		$EnemySpawnCooldown.wait_time = enemy_table[wave][1]

	var viewport = get_viewport_rect()
	var offset = (viewport.size / 2) + Vector2(100, 100)
	var player_pos = $Player.position
	var enemy_spawn_position_table = [
		Vector2(player_pos.x - offset.x, player_pos.y - offset.y),
		Vector2(player_pos.x + offset.x, player_pos.y - offset.y),
		Vector2(player_pos.x - offset.x, player_pos.y + offset.y),
		Vector2(player_pos.x + offset.x, player_pos.y + offset.y),
	]

	if $EnemySpawnCooldown.is_stopped():
		var pos = enemy_spawn_position_table.pick_random()
		for enemy in enemy_table[wave][2]:
			var new_enemy = enemy.instantiate()
			var rng = RandomNumberGenerator.new()
			new_enemy.position = pos + Vector2.ONE * rng.randf_range(-250.0, 250.0)
			add_child(new_enemy)

			#var query = PhysicsShapeQueryParameters2D.new()
			#query.shape = new_enemy.get_node("Collider")
			#while(!world_state.collide_shape(query).is_empty()):
			while pos.y > 200 || pos.y < -1000:  # bad fix but can't be bothered to get the good one working
				pos = enemy_spawn_position_table.pick_random()
				new_enemy.position = pos + Vector2.ONE * rng.randf_range(-250.0, 250.0)
				#query.shape = new_enemy.get_node("CollisionShape2D")
		$EnemySpawnCooldown.start()


func remove_enemies():
	var enemies = get_tree().get_nodes_in_group("Enemy")
	for enemy in enemies:
		enemy.queue_free()


func _ready():
	DebugUI.get_node("Stats").add_property(
		$EnemySpawnCooldown, "time_left", DebugProperty.DisplayOption.ROUNDED
	)
	DebugUI.get_node("Stats").add_property(
		self, "time_elapsed", DebugProperty.DisplayOption.ROUNDED
	)
	DebugUI.get_node("Stats").add_property(self, "wave", DebugProperty.DisplayOption.DEFAULT)


func _process(delta):
	if Globals.is_dying:
		remove_enemies()
		return

	Globals.time_elapsed += delta
	spawn_enemies()
