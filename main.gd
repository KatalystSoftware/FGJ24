extends Node2D

@export var EnemyScene = preload("res://enemies/base/base_enemy.tscn")

#Format:
#[Duration, How often do we spawn these enemies, [enemies]
var enemyTable = [
	[0, 1, []],
	[10, 1, [EnemyScene, EnemyScene]],
	[10, 1, [EnemyScene, EnemyScene]],
]
var timer = 0.0
var stepTimer = 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace with function body.


func spawnEnemies(delta):
	var index = 0
	var cutoff = 0.0
	while cutoff < timer && index < enemyTable.size() - 1:
		cutoff += enemyTable[index][0]
		index += 1

	var viewport = get_viewport_rect()
	var viewport_size = viewport.size
	viewport.position -= viewport_size / 2  # burger fix
	var nudge = 100
	var enemySpawnPosTable = [
		Vector2(viewport.position.x - nudge, viewport.position.y - nudge),
		Vector2(viewport.end.x + nudge, viewport.position.y - nudge),
		Vector2(viewport.position.x - nudge, viewport.end.y + nudge),
		Vector2(viewport.end.x + nudge, viewport.end.y + nudge),
		Vector2(viewport.position.x + viewport_size.x / 2, viewport.end.y + nudge),
		Vector2(viewport.position.x + viewport_size.x / 2, viewport.position.y - nudge),
		Vector2(viewport.position.x - nudge, viewport.position.y + viewport_size.y / 2),
		Vector2(viewport.end.x + nudge, viewport.position.y + viewport_size.y / 2),
	]

	if stepTimer >= enemyTable[index][1]:
		var pos = enemySpawnPosTable.pick_random()
		for enemy in enemyTable[index][2]:
			var new_enemy = enemy.instantiate()
			new_enemy.position = pos
			add_child(new_enemy)

	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer += delta
	stepTimer += delta
	spawnEnemies(delta)
	pass
