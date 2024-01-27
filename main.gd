extends Node2D

@export var EnemyScene = preload("res://enemies/base/base_enemy.tscn")

#Format:
#[Duration, How often do we spawn these enemies, [enemies]
var enemy_table = [
	[0, 1, []],
	[10, 1, [EnemyScene, EnemyScene]],
	[10, 1, [EnemyScene, EnemyScene]],
]
var time_elapsed = 0.0


func spawn_enemies():
	var index = 0
	var cutoff = 0.0

	while cutoff < time_elapsed && index < enemy_table.size() - 1:
		cutoff += enemy_table[index][0]
		index += 1
		$EnemySpawnCooldown.wait_time = enemy_table[index][1]

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
		for enemy in enemy_table[index][2]:
			var new_enemy = enemy.instantiate()
			new_enemy.position = pos
			add_child(new_enemy)
		$EnemySpawnCooldown.start()


func _process(delta):
	time_elapsed += delta
	spawn_enemies()
