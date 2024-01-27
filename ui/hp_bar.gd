extends ProgressBar

var player: CharacterBody2D


func _ready():
	player = get_tree().get_first_node_in_group("Player")
	max_value = PlayerStats.max_health
	value = player.get_node("Health").count


func _process(_delta):
	if not player or player.is_queued_for_deletion():
		value = 0
		return

	max_value = PlayerStats.max_health
	value = player.get_node("Health").count
