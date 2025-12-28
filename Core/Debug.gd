extends Node

func _on_gain_exp_button_3_pressed() -> void:
	LevelUpController._on_experience_gained(10000)
	_trigger_cooldown(60)


func _on_gain_exp_button_2_pressed() -> void:
	LevelUpController._on_experience_gained(1000)
	_trigger_cooldown(15)


func _on_gain_exp_button_pressed() -> void:
	LevelUpController._on_experience_gained(100)
	_trigger_cooldown(2)

func _on_level_up_button_pressed() -> void:
	LevelUpController.debug_level_up()
	_trigger_cooldown(2)

func _trigger_cooldown(seconds : float):
	$"CanvasLayer/Debug Buttons/Level Up Button".disabled = true
	$"CanvasLayer/Debug Buttons/GainExpButton".disabled = true
	$"CanvasLayer/Debug Buttons/GainExpButton2".disabled = true
	$"CanvasLayer/Debug Buttons/GainExpButton3".disabled = true
	$"CanvasLayer/Debug Buttons/GainExpButton3".disabled = true
	await get_tree().create_timer(seconds).timeout
	$"CanvasLayer/Debug Buttons/Level Up Button".disabled = false
	$"CanvasLayer/Debug Buttons/GainExpButton".disabled = false
	$"CanvasLayer/Debug Buttons/GainExpButton2".disabled = false
	$"CanvasLayer/Debug Buttons/GainExpButton3".disabled = false
	$"CanvasLayer/Debug Buttons/GainExpButton3".disabled = false
