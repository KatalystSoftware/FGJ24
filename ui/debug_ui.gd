extends CanvasLayer


func _physics_process(_delta):
	if Input.is_action_just_pressed("show_debug_stats"):
		visible = not visible
