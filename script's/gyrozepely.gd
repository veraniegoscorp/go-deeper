extends CollisionShape2D

#con estos dos contramos el flujo principal
var attacking = false
var locked_rotation = 0.0


func _ready() -> void:
	hide()

func _process(_delta):
	if not attacking:
		look_at(get_global_mouse_position()) #look at gira el marker a donde esta el raton y el get global da la posicion del raton
		rotation += deg_to_rad(45)
	if Input.is_action_just_pressed("hit") and not attacking:
		attack()




func attack():
	attacking = true
	
	# le asignamos el valor para que no se mueva mas
	locked_rotation = rotation
	
	# activamos la hitbox
	$hurtbox/CollisionShape2D.disabled = false
	show()
	
	# esperamos a que termine el swing
	await swing()

	# desactivas
	$hurtbox/CollisionShape2D.disabled = true
	hide()
	attacking = false


func swing():
	
	var start = locked_rotation - deg_to_rad(60)
	var end = locked_rotation + deg_to_rad(60)
	
	rotation = start
	"""get_process_delta_time() devuelve el tiempo pasado entre frames por ejemplo
	0,16 * 8 y si aumentamos el * 8 le damos mas velocidad al swing"""
	var t = 0.0
	while t < 1.0:
		t += get_process_delta_time() * 8 
		rotation = lerp(start, end, t)
		await get_tree().process_frame
