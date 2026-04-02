extends Area2D


func _on_body_entered(body: Node2D) -> void:
	print("Entró algo:", body.name)
	if body.name == ("little knight"):
		print("Es el jugador!")
		call_deferred("go_to_scene")

func go_to_scene():
	get_tree().change_scene_to_file("res://tcnes/city_main.tscn")
