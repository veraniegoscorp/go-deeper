extends Area2D

@export var esena: PackedScene

func _on_body_entered(body: Node2D) -> void:
	if body.name == "little knight":
		call_deferred("go_to_scene")

func go_to_scene():
	get_tree().change_scene_to_packed(esena)
