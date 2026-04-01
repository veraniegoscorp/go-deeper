extends Node2D

const SPAWN_1_ST_DIALOGUE = preload("uid://pmyu8525k02c")
const SPAWN_2_COND_DIALOGUE = preload("uid://b32pimlgj3u11")

@onready var black = $Black

func _ready() -> void:
	await start_sequence()

func start_sequence() -> void:
# 🌑 Fade out
	await fade_out()

	# 💬 Diálogo 1
	DialogueManager.show_dialogue_balloon(SPAWN_1_ST_DIALOGUE)
	await DialogueManager.dialogue_ended
	await get_tree().create_timer(5.0).timeout
	# 💬 Diálogo 2
	DialogueManager.show_dialogue_balloon(SPAWN_2_COND_DIALOGUE)
	await DialogueManager.dialogue_ended

func fade_out() -> void:
	black.modulate.a = 1.0
	
	var tween = create_tween()
	tween.tween_property(black, "modulate:a", 0.0, 2.0)
	
	await tween.finished
