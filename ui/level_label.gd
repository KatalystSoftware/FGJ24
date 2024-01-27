extends Label

var player: CharacterBody2D


func _ready():
	player = get_tree().get_first_node_in_group("Player")
	text = str(player.get_node("Experience").level)


func _process(_delta):
	if not player or player.is_queued_for_deletion():
		text = "0"
		return

	text = str(player.get_node("Experience").level)
