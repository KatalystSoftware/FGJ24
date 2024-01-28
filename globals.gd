extends Node

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

var is_dying = false
var time_elapsed = 0.0


func get_random_upgrades():
	var shuffled_options = UpgradeOption.keys()
	shuffled_options.shuffle()
	var options = shuffled_options.slice(0, 4)
	return options


func upgrade_stat(option: UpgradeOption) -> void:
	match option:
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
