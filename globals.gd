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
			PlayerStats.max_health += (
				PlayerStats.BASE_MAX_HEALTH * PlayerStats.MAX_HEALTH_GROWTH_RATE
			)
		UpgradeOption.INCREASE_MOVEMENT_SPEED:
			PlayerStats.movement_speed += (
				PlayerStats.BASE_MOVEMENT_SPEED * PlayerStats.MOVEMENT_SPEED_GROWTH_RATE
			)
		UpgradeOption.INCREASE_EXPERIENCE:
			PlayerStats.experience_multiplier += (
				PlayerStats.BASE_EXPERIENCE_MULTIPLIER
				* PlayerStats.EXPERIENCE_MULTIPLIER_GROWTH_RATE
			)
		UpgradeOption.INCREASE_AMOUNT:
			PlayerStats.shot_amount += PlayerStats.SHOT_AMOUNT_GROWTH_RATE
		UpgradeOption.INCREASE_DAMAGE:
			PlayerStats.shot_damage += (
				PlayerStats.BASE_SHOT_DAMAGE * PlayerStats.SHOT_DAMAGE_GROWTH_RATE
			)
		UpgradeOption.REDUCE_COOLDOWN:
			PlayerStats.shot_cooldown -= (
				PlayerStats.BASE_SHOT_COOLDOWN * PlayerStats.SHOT_COOLDOWN_GROWTH_RATE
			)
		UpgradeOption.INCREASE_SHOT_SPEED:
			PlayerStats.shot_speed += (
				PlayerStats.BASE_SHOT_SPEED * PlayerStats.SHOT_SPEED_GROWTH_RATE
			)
		UpgradeOption.INCREASE_SHOT_LIFETIME:
			PlayerStats.shot_lifetime += (
				PlayerStats.BASE_SHOT_LIFETIME * PlayerStats.SHOT_LIFETIME_GROWTH_RATE
			)


func reset_stats():
	is_dying = false
	time_elapsed = 0.0
	PlayerStats.max_health = PlayerStats.BASE_MAX_HEALTH
	PlayerStats.movement_speed = PlayerStats.BASE_MOVEMENT_SPEED
	PlayerStats.experience_multiplier = PlayerStats.BASE_EXPERIENCE_MULTIPLIER
	PlayerStats.shot_amount = PlayerStats.BASE_SHOT_AMOUNT
	PlayerStats.shot_damage = PlayerStats.BASE_SHOT_DAMAGE
	PlayerStats.shot_cooldown = PlayerStats.BASE_SHOT_COOLDOWN
	PlayerStats.shot_speed = PlayerStats.BASE_SHOT_SPEED
	PlayerStats.shot_lifetime = PlayerStats.BASE_SHOT_LIFETIME
	PlayerStats.shot_spread = PlayerStats.BASE_SHOT_SPREAD
