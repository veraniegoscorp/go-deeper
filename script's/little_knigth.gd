extends CharacterBody2D

var SPEED = 100.0
const MIN_ANIMATION_TIME = 0.1 # tiempo mínimo antes de cambiar animación

@onready var sprite = $AnimatedSprite2D

var last_direction := Vector2.DOWN
var current_animation := ""
var animation_timer := 0.0
var can_move= true

func _ready():
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

@warning_ignore("unused_parameter")
func _on_dialogue_started(dialogue):
	can_move = false
	SPEED=0
	velocity = Vector2.ZERO

@warning_ignore("unused_parameter")
func _on_dialogue_ended(dialogue):
	can_move = true
	SPEED=100


func _physics_process(delta: float) -> void:
	var input_vector := Vector2.ZERO
	
	if not can_move:
		velocity = Vector2.ZERO
		move_and_slide()
		_update_animation(last_direction, Vector2.ZERO)
		$pasos.stop()
		return

	# Capturar input
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_vector = input_vector.normalized()

	# 🔊 SONIDO DE PASOS (AHORA SÍ FUNCIONA)
	if input_vector != Vector2.ZERO:
		if not $pasos.playing:
			$pasos.play()
	else:
		$pasos.stop()

	# Guardar dirección
	if input_vector != Vector2.ZERO:
		last_direction = input_vector

	# Movimiento
	velocity = input_vector * SPEED
	move_and_slide()

	# Animaciones
	animation_timer -= delta
	_update_animation(last_direction, input_vector)

func _update_animation(direction: Vector2, input_vector: Vector2) -> void:
	var new_animation := ""

	if input_vector == Vector2.ZERO:
		# Idle según última dirección
		if abs(direction.x) > 0 and abs(direction.y) > 0:
			new_animation = "idle_diagonal_down"
			sprite.flip_h = direction.x < 0
		elif direction.x > 0:
			new_animation = "idle_right"
			sprite.flip_h = false
		elif direction.x < 0:
			new_animation = "idle_right"
			sprite.flip_h = true
		elif direction.y < 0:
			new_animation = "idle_up"
		else:
			new_animation = "idle_down"
	else:
		# Movimiento
		if abs(direction.x) > 0 and abs(direction.y) > 0:
			if direction.y < 0:
				new_animation = "walk_diagonal_up"
			else:
				new_animation = "walk_diagonal"
			sprite.flip_h = direction.x < 0
		elif abs(direction.x) > 0:
			new_animation = "walk_right"
			sprite.flip_h = direction.x < 0
		elif direction.y < 0:
			new_animation = "walk_up"
		else:
			new_animation = "walk_down"

	# Cambiar animación solo si es diferente y pasó el tiempo mínimo
	if new_animation != current_animation and animation_timer <= 0:
		sprite.play(new_animation)
		current_animation = new_animation
		animation_timer = MIN_ANIMATION_TIME
