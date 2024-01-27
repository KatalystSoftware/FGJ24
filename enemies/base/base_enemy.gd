class_name BaseEnemy
extends Enemy

@export var DamageAreaScene = preload("res://enemies/base/damage_area.tscn")


func _physics_process(_delta):
	move_and_slide()

	if $Cooldown.is_stopped():
		var damage_area: DamageArea = DamageAreaScene.instantiate()
		add_child(damage_area)
		$Cooldown.start()
