extends CanvasLayer

enum UpgradeOption {
	INCREASE_HEALTH,
	INCREASE_MOVEMENT_SPEED,
	INCREASE_AMOUNT,
	INCREASE_DAMAGE,
	INCREASE_EXPERIENCE,
	REDUCE_COOLDOWN,
	INCREASE_SHOT_SPEED,
	INCREASE_SHOT_LIFETIME,
	REDUCE_SPREAD
}


func show_options():
	randomize_options()
	get_tree().paused = true
	visible = true


func hide_options():
	var node = $VBoxContainer/HBoxContainer
	for child in node.get_children():
		node.remove_child(child)
		child.queue_free()
	get_tree().paused = false
	visible = false


func randomize_options():
	var shuffled_options = UpgradeOption.keys()
	shuffled_options.shuffle()
	var options = shuffled_options.slice(0, 3)

	for option in options:
		var button = Button.new()
		button.text = option
		button.pressed.connect(func(): _button_pressed(UpgradeOption[option]))
		$VBoxContainer/HBoxContainer.add_child(button)


func _button_pressed(type: UpgradeOption):
	match type:
		UpgradeOption.INCREASE_HEALTH:
			PlayerStats.max_health += PlayerStats.BASE_MAX_HEALTH * 0.1
		UpgradeOption.INCREASE_MOVEMENT_SPEED:
			PlayerStats.movement_speed += PlayerStats.BASE_MOVEMENT_SPEED * 0.1
		UpgradeOption.INCREASE_EXPERIENCE:
			PlayerStats.experience_multiplier += PlayerStats.BASE_EXPERIENCE_MULTIPLIER * 0.1
		UpgradeOption.INCREASE_AMOUNT:
			PlayerStats.shot_amount += 1
		UpgradeOption.INCREASE_DAMAGE:
			PlayerStats.shot_damage += 1
		UpgradeOption.REDUCE_COOLDOWN:
			PlayerStats.shot_cooldown -= PlayerStats.BASE_SHOT_COOLDOWN * 0.1
		UpgradeOption.INCREASE_SHOT_SPEED:
			PlayerStats.shot_speed += PlayerStats.BASE_SHOT_SPEED * 0.1
		UpgradeOption.INCREASE_SHOT_LIFETIME:
			PlayerStats.shot_lifetime += PlayerStats.BASE_SHOT_LIFETIME * 0.1
		UpgradeOption.REDUCE_SPREAD:
			PlayerStats.shot_spread -= PlayerStats.BASE_SHOT_SPREAD * 0.05

	hide_options()
