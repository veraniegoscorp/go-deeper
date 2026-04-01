extends Node2D
pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AudioStreamPlayer.play()
	await get_tree().create_timer(2.7).timeout  # casi hasta los 3s
	
	var tween = create_tween()
	tween.tween_property($AudioStreamPlayer, "volume_db", -30, 0.3) # fade corto
	
	$AudioStreamPlayer2.play()
	await tween.finished
	$AudioStreamPlayer.stop()
	await $AudioStreamPlayer2.finished
	await get_tree().create_timer(0.5).timeout
	$AudioStreamPlayer3.play()
	await $AudioStreamPlayer3.finished
	
	get_tree().change_scene_to_file("res://tcnes/spawn.tscn")
	
	
	
	
