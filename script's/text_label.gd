extends Node2D


const SEE_AROUND = preload("uid://dv5buwpta8bpa")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("default")
	DialogueManager.dialogue_started.connect(dialogo_activo)
	DialogueManager.dialogue_ended.connect(dialogo_terminado)

var is_player_close=false
var is_dialoge_active=false

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	if is_player_close and Input.is_action_just_pressed("ui_accept") and not is_dialoge_active:
		DialogueManager.show_dialogue_balloon(SEE_AROUND)
		is_player_close=false

@warning_ignore("unused_parameter")
func _on_area_2d_body_entered(body: Node2D) -> void:
	is_player_close=true

@warning_ignore("unused_parameter")
func dialogo_activo(dialogue):
	is_dialoge_active=true

@warning_ignore("unused_parameter")
func dialogo_terminado(dialogue):
	await get_tree().create_timer(0.2).timeout
	is_dialoge_active=false
