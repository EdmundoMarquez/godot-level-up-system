extends Resource
class_name ItemConfiguration

@export var items : Array[Item]

func get_max_item_level() -> int:
	var max_level = 0
	for i in items:
		if i.min_level > max_level:
			max_level = i.min_level
	return max_level

func find_item_by_level(level: int) -> Item:
	for i in items:
		if i.min_level == level:
			return i
	return null