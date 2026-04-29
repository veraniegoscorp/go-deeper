extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fade_out()
	$AudioStreamPlayer.play()
	$nivel/AnimatedSprite2D.play("default")
	$AudioStreamPlayer2D.play()


func fade_out() -> void:
	$black_entry.modulate.a = 1.0
	var tween = create_tween()
	tween.tween_property($black_entry, "modulate:a", 0.0, 1.0)
	await tween.finished
