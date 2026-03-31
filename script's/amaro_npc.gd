extends Node2D


const AMARO_NPC = preload("uid://dlb6sj3h7oprq")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DialogueManager.dialogue_started.connect(dialogo_activo)
	DialogueManager.dialogue_ended.connect(dialogo_terminado)

var is_player_close=false
var is_dialoge_active=false

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	if is_player_close and Input.is_action_just_pressed("ui_accept") and not is_dialoge_active:
		$AnimatedSprite2D.play("talk")
		DialogueManager.show_dialogue_balloon(AMARO_NPC)
		is_player_close=false


@warning_ignore("unused_parameter")
func dialogo_activo(dialogue):
	is_dialoge_active=true

@warning_ignore("unused_parameter")
func dialogo_terminado(dialogue):
	await get_tree().create_timer(0.2).timeout
	is_dialoge_active=false


@warning_ignore("unused_parameter")
func _on_body_entered(body: Node2D) -> void:
	is_player_close=true
