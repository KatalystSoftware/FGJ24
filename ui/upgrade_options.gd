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
		button.text = option_key
		button.pressed.connect(func(): _button_pressed(option))
		$VBoxContainer/HBoxContainer.add_child(button)


func _button_pressed(option: Globals.UpgradeOption):
	Globals.upgrade_stat(option)
	hide_options()
