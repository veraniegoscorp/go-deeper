extends CharacterBody2D

const SPEED = 100.0
const MIN_ANIMATION_TIME = 0.1 # tiempo mínimo antes de cambiar animación

@onready var sprite = $AnimatedSprite2D

var last_direction := Vector2.DOWN
var current_animation := ""
var animation_timer := 0.0

func _physics_process(delta: float) -> void:
	var input_vector := Vector2.ZERO

	# Capturar input desde WASD
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_vector = input_vector.normalized()

	# Guardar la última dirección si hay movimiento
	if input_vector != Vector2.ZERO:
		last_direction = input_vector

	# Mover al jugador
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
