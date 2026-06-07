extends Area2D

var velocidad = 35
var jugador = null
var jugador_dentro = null
var seguir = false

func _ready():
	$AnimatedSprite2D.play("new_animation")
	jugador = get_tree().get_first_node_in_group("player")


func _process(delta):
	if seguir and jugador:
		var direccion = (jugador.global_position - global_position).normalized()
		global_position += direccion * velocidad * delta


func _on_body_entered(body):
	if body.name == "little knight":
		jugador_dentro = body
		body.recibir_dano(10) # daño instantáneo
		$Timer.start()


func _on_body_exited(body):
	if body == jugador_dentro:
		jugador_dentro = null
		$Timer.stop()


func _on_timer_timeout():
	if jugador_dentro:
		jugador_dentro.recibir_dano(10)


func _on_visible_on_screen_notifier_2d_screen_entered():
	seguir = true


func _on_visible_on_screen_notifier_2d_screen_exited():
	seguir = false
