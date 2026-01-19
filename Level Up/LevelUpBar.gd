extends ProgressBar
class_name LevelUpBar

@export var level_text: Label

func _ready() -> void:
	value = 0
	SignalBus.on_experience_gained.connect(_on_experience_gained)
	SignalBus.on_level_up.connect(_on_level_up)
	_initialize(LevelUpController.current_level, LevelUpController.current_experience, LevelUpController.experience_to_next_level)

func _initialize(level: int, current_experience: int, experience_to_next_level: int) -> void:
	max_value = experience_to_next_level
	value = current_experience
	level_text.text = "LEVEL " + str(level)

func _on_experience_gained(exp_amount: int) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, "value", min(value + exp_amount, max_value), 2.0).set_ease(Tween.EASE_IN_OUT)

func _on_level_up(previous_level: int, levels_gained: int, remaining_experience: int) -> void:
	var tween = get_tree().create_tween()
	tween.set_parallel(false)
	for _i in levels_gained:
		tween.tween_property(self, "value", max_value, 2.0).set_ease(Tween.EASE_IN_OUT)
		tween.tween_callback(set_level_bar.bind(previous_level + _i + 1))
	tween.tween_callback(set_exp_value.bind(remaining_experience, LevelUpController.experience_to_next_level))
	tween.tween_callback(func(): SignalBus.on_level_updated.emit(previous_level, levels_gained))

func set_level_bar(new_level: int):
	level_text.text = "LEVEL " + str(new_level)
	value = 0

func set_exp_value(experience: int, exp_to_next_level):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "value", experience, 2.0).set_ease(Tween.EASE_IN_OUT)
	max_value = exp_to_next_level
