extends Node2D  # center-weapons

class WeaponData:
	var name: String
	var texture: Texture2D
	var damage: int
	var swing_range: float
	var swing_speed: float
	func _init(n, tex, dmg, range_deg, speed):
		name = n
		texture = tex
		damage = dmg
		swing_range = deg_to_rad(range_deg)
		swing_speed = speed

var weapons: Array[WeaponData] = []
var current_weapon_index = 0

@onready var hurtbox = $hurtbox
@onready var sword_sprite = $"hurtbox/sword-swing"

var attacking = false
var locked_rotation = 0.0

func _ready():
	# ejemplo, ajusta las rutas a tus texturas reales
	weapons.append(WeaponData.new("Espada", preload("res://weapons/001.png"), 10, 120, 10.0))
	#weapons.append(WeaponData.new("Hacha", preload("res://sprites/axe.png"), 18, 90, 6.0))
	#weapons.append(WeaponData.new("Daga", preload("res://sprites/dagger.png"), 5, 150, 16.0))
	equip(0)
	$hurtbox/CollisionShape2D.disabled = true
	hurtbox.hide()

func equip(index: int):
	current_weapon_index = index
	var w = weapons[index]
	sword_sprite.texture = w.texture

func current_weapon() -> WeaponData:
	return weapons[current_weapon_index]


#func _unhandled_input(event):
#	if event.is_action_pressed("next_weapon"):
#		equip((current_weapon_index + 1) % weapons.size())
#	elif event.is_action_pressed("prev_weapon"):
#		equip((current_weapon_index - 1 + weapons.size()) % weapons.size())

func _process(_delta):
	if not attacking:
		rotation = (get_global_mouse_position() - global_position).angle()
		if Input.is_action_just_pressed("hit"):
			attack()

func attack():
	attacking = true
	var w = current_weapon()
	locked_rotation = rotation
	$hurtbox/CollisionShape2D.disabled = false
	hurtbox.show()
	await swing(w.swing_range, w.swing_speed)
	$hurtbox/CollisionShape2D.disabled = true
	hurtbox.hide()
	attacking = false

func swing(range_rad: float, speed: float):
	var start = locked_rotation - range_rad / 2
	var end = locked_rotation + range_rad / 2
	rotation = start
	var t = 0.0
	while t < 1.0:
		t += get_process_delta_time() * speed
		rotation = lerp(start, end, t)
		await get_tree().process_frame
