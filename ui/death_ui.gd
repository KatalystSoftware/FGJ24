extends CanvasLayer


func _on_restart_pressed():
	get_tree().reload_current_scene()
	Globals.reset_stats()


func _on_quit_to_menu_pressed():
	get_tree().change_scene_to_file("res://main_menu.tscn")
