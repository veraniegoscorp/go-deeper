extends Area2D


@export var dialogo: Resource
var is_player_close=false
var is_dialoge_active=false


func _ready() -> void:
	DialogueManager.dialogue_started.connect(dialogue_started)
	DialogueManager.dialogue_ended.connect(dialogo_terminado)


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") and is_player_close and not is_dialoge_active:
		DialogueManager.show_dialogue_balloon(dialogo)


func dialogue_started(_dialogue):
	is_dialoge_active=true


func dialogo_terminado(_dialogue):
	await get_tree().create_timer(0.2).timeout
	is_dialoge_active=false

func _on_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.name=="little knight":
		is_player_close=false

func _on_body_entered(body: Node2D) -> void:
	if body.name=="little knight":
		is_player_close=true
