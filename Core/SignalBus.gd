extends Node

signal on_experience_gained(exp_gained: int)
signal on_level_up(previous_level: int, levels_gained: int, remaining_experience: int)
signal on_level_updated(level: int, levels_gained: int)