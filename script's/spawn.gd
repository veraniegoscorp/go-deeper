extends Node2D

const SPAWN_1_ST_DIALOGUE = preload("uid://pmyu8525k02c")
const SPAWN_2_COND_DIALOGUE = preload("uid://b32pimlgj3u11")


func _ready() -> void:
	DialogueManager.show_dialogue_balloon(SPAWN_1_ST_DIALOGUE)
	await get_tree().create_timer(5.0).timeout
	DialogueManager.show_dialogue_balloon(SPAWN_2_COND_DIALOGUE)
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass
