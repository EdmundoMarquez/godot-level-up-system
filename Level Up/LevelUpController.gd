extends Node

var current_level: int = 1
var current_experience: int = 0
var experience_to_next_level: int = 100
var experience_bonus: float = 0.0

func _on_experience_gained(exp_amount: int) -> void:
	if exp_amount < 0:
		return
	current_experience += exp_amount * (1 + experience_bonus)
	
	var temp_level = current_level
	var total_levels_gained = 0
	var remaining_experience = exp_amount
	while remaining_experience > 0:
		remaining_experience -= experience_to_next_level
		print("Gained " + str(exp_amount) + " experience. Current EXP: " + str(current_experience) + "/" + str(experience_to_next_level) + " (Exp Bonus: " + str(experience_bonus * 100) + "%)")
		if current_experience >= experience_to_next_level:
			total_levels_gained += 1
			_level_up()

	if total_levels_gained > 0:
		SignalBus.on_level_up.emit(temp_level, total_levels_gained, current_experience)
		return
	SignalBus.on_experience_gained.emit(exp_amount)
	print("Gained " + str(exp_amount) + " experience. Current EXP: " + str(current_experience) + "/" + str(experience_to_next_level) + " (Exp Bonus: " + str(experience_bonus * 100) + "%)")

func _level_up() -> void:
	current_experience -= experience_to_next_level
	current_level += 1
	experience_to_next_level = int(experience_to_next_level * 1.2)
	print("Leveled up! New level: " + str(current_level))

func debug_level_up():
	var temp_level = current_level
	current_experience = experience_to_next_level
	_level_up()
	SignalBus.on_level_up.emit(temp_level, 1, current_experience)
