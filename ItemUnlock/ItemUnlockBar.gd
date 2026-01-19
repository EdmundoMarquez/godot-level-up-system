extends Node

@export var item_min_size: Vector2 = Vector2(65, 65)
@export var progress_bar_fill_offset: float = -5.0

var item_configuration = ResourceLoader.load("res://ItemUnlock/item_defaults.tres").duplicate()
var level_item = preload("res://ItemUnlock/Item.tscn")
var max_item_level

@onready var scroll_container = $ScrollContainer
@onready var main_panel = $ScrollContainer/MainPanel
@onready var progress_bar = $ScrollContainer/MainPanel/ProgressBar
@onready var items_container = $ScrollContainer/MainPanel/ItemsContainer

var generated_items: Array[Control] = []

func _ready() -> void:
	_generate_items()
	main_panel.size = items_container.size
	var initial_value = ((1.0 / item_configuration.get_max_item_level()) * 100) + progress_bar_fill_offset
	progress_bar.set_deferred("value", initial_value)
	SignalBus.on_level_updated.connect(on_level_up)

func _generate_items():
	var item_queue: Array = item_configuration.items.duplicate()
	max_item_level = item_configuration.get_max_item_level()

	for _i in range(1, max_item_level + 1):
		var item = item_queue[0]
		if _i == item.min_level:
			_set_item_instance(item)
			item_queue.remove_at(0)
		else:
			var empty = Control.new()
			empty.custom_minimum_size = item_min_size
			items_container.add_child(empty)
			generated_items.append(empty)

func _set_item_instance(item: Item):
	var instance = level_item.instantiate()
	instance.get_node("Label").text = str(item.min_level)
	instance.get_node("TextureRect").texture = item.item_icon
	items_container.add_child(instance)
	generated_items.append(instance)

func on_level_up(level: int, levels_gained: int):
	var initial_value = ((float(level) / item_configuration.get_max_item_level()) * 100) + progress_bar_fill_offset
	progress_bar.value = initial_value
	var tween = get_tree().create_tween()
	var final_value = ((float(level + levels_gained) / item_configuration.get_max_item_level()) * 100) + progress_bar_fill_offset
	tween.tween_property(progress_bar, "value", final_value, 0.5)
	var h_scroll_bar = scroll_container.get_h_scroll_bar()
	var scroll_value = ((float(level + levels_gained) / item_configuration.get_max_item_level()) * h_scroll_bar.max_value) + progress_bar_fill_offset * 100
	print(str(scroll_value))
	tween.tween_property(scroll_container, "scroll_horizontal", scroll_value, 0.5)
