extends Node2D

@export var EnemyScene = preload("res://enemies/base/base_enemy.tscn")

#Format:
#[Duration, How often do we spawn these enemies, [enemies]
var enemy_table = [
	[10, 1, [EnemyScene, EnemyScene]],
	[10, 1, [EnemyScene, EnemyScene]],
]
var time_elapsed = 0.0
var next_wave_at = 10.0
var wave = 0


func spawn_enemies():
	if next_wave_at <= time_elapsed && wave < enemy_table.size() - 1:
		next_wave_at += enemy_table[wave][0]
		wave += 1
		$EnemySpawnCooldown.wait_time = enemy_table[wave][1]

	var viewport = get_viewport_rect()
	var viewport_size = viewport.size
	viewport.position -= viewport_size / 2  # burger fix
	var nudge = 100
	var enemy_spawn_position_table = [
		Vector2(viewport.position.x - nudge, viewport.position.y - nudge),
		Vector2(viewport.end.x + nudge, viewport.position.y - nudge),
		Vector2(viewport.position.x - nudge, viewport.end.y + nudge),
		Vector2(viewport.end.x + nudge, viewport.end.y + nudge),
		Vector2(viewport.position.x + viewport_size.x / 2, viewport.end.y + nudge),
		Vector2(viewport.position.x + viewport_size.x / 2, viewport.position.y - nudge),
		Vector2(viewport.position.x - nudge, viewport.position.y + viewport_size.y / 2),
		Vector2(viewport.end.x + nudge, viewport.position.y + viewport_size.y / 2),
	]

	if $EnemySpawnCooldown.is_stopped():
		var pos = enemy_spawn_position_table.pick_random()
		for enemy in enemy_table[wave][2]:
			var new_enemy = enemy.instantiate()
			var rng = RandomNumberGenerator.new()
			new_enemy.position = pos + Vector2.ONE * rng.randf_range(-250.0, 250.0)
			add_child(new_enemy)
		$EnemySpawnCooldown.start()


func _ready():
	DebugUI.get_node("Stats").add_property(
		$EnemySpawnCooldown, "time_left", DebugProperty.DisplayOption.ROUNDED
	)
	DebugUI.get_node("Stats").add_property(
		self, "time_elapsed", DebugProperty.DisplayOption.ROUNDED
	)
	DebugUI.get_node("Stats").add_property(self, "wave", DebugProperty.DisplayOption.DEFAULT)


func _process(delta):
	time_elapsed += delta
	spawn_enemies()
