extends Resource
class_name ItemConfiguration

@export var items : Array[Item]

func get_max_item_level() -> int:
	var max_level = 0
	for _i in items:
		if _i.min_level > max_level:
			max_level = _i.min_level
	return max_level