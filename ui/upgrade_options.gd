extends CanvasLayer


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
	var options = Globals.get_random_upgrades()

	for option_key in options:
		var option = Globals.UpgradeOption[option_key]
		var button = Button.new()
		button.text = upgrade_text(option)
		button.pressed.connect(func(): _button_pressed(option))
		$VBoxContainer/HBoxContainer.add_child(button)


func _button_pressed(option: Globals.UpgradeOption):
	Globals.upgrade_stat(option)
	hide_options()


func upgrade_text(option: Globals.UpgradeOption):
	var show_text = ""

	match option:
		Globals.UpgradeOption.INCREASE_HEALTH:
			show_text = ("Increase max health by %s%%" % [PlayerStats.MAX_HEALTH_GROWTH_RATE * 100])
		Globals.UpgradeOption.INCREASE_MOVEMENT_SPEED:
			show_text = (
				"Increase movement speed by %s%%" % [PlayerStats.MOVEMENT_SPEED_GROWTH_RATE * 100]
			)
		Globals.UpgradeOption.INCREASE_EXPERIENCE:
			show_text = (
				"Increase experience gain by %s%%"
				% [PlayerStats.EXPERIENCE_MULTIPLIER_GROWTH_RATE * 100]
			)
		Globals.UpgradeOption.INCREASE_AMOUNT:
			show_text = (
				"Increase shot amount by %s%%" % [PlayerStats.SHOT_AMOUNT_GROWTH_RATE * 100]
			)
		Globals.UpgradeOption.INCREASE_DAMAGE:
			show_text = (
				"Increase shot damage by %s%%" % [PlayerStats.SHOT_DAMAGE_GROWTH_RATE * 100]
			)
		Globals.UpgradeOption.REDUCE_COOLDOWN:
			show_text = (
				"Reduce shot cooldown by %s%%" % [PlayerStats.SHOT_COOLDOWN_GROWTH_RATE * 100]
			)
		Globals.UpgradeOption.INCREASE_SHOT_SPEED:
			show_text = ("Increase shot speed by %s%%" % [PlayerStats.SHOT_SPEED_GROWTH_RATE * 100])
		Globals.UpgradeOption.INCREASE_SHOT_LIFETIME:
			show_text = (
				"Increase shot lifetime by %s%%" % [PlayerStats.SHOT_LIFETIME_GROWTH_RATE * 100]
			)

	return show_text
