extends Node2D

@export var next_scene: String

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "little knight":
		start_cutscene(body)

func start_cutscene(player):
	player.can_move = false
	await move_player_right(player)
	get_tree().change_scene_to_file("res://tcne's/city_main.tscn")

func move_player_right(player):
	var duration = 1.5
	var time = 0.0
	var speed = 10.0
	
	while time < duration:
		player.position.x += speed * get_process_delta_time()
		time += get_process_delta_time()
		await get_tree().process_frame
