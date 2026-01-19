extends Node

@export var message_text : RichTextLabel

func initialize(text: String):
	message_text.text = text

func _on_button_pressed() -> void:
	$AnimationPlayer.play_backwards("show_popup")
	await $AnimationPlayer.animation_finished
	queue_free()
