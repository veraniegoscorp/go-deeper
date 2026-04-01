extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("little knight"):
		call_deferred("go_to_scene")

func go_to_scene() -> void:
	get_tree().change_scene_to_file("res://tcnes/city_main.tscn")
