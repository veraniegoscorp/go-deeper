extends Control

const SLOT_SCENE = preload("res://tcnes/inventory_slot.tscn")
const SLOT_COUNT = 20

@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var grid: GridContainer = $GridContainer # agrégalo en el editor dentro del libro

var slots: Array = []
var items: Array[Item] = []
var is_open = false
var player_ref: Node = null # referencia al center_weapons del jugador

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS # para que funcione con el juego pausado
	hide()
	_build_slots()
	_load_starting_items()

func _build_slots():
	for i in SLOT_COUNT:
		var slot = SLOT_SCENE.instantiate()
		grid.add_child(slot)
		slot.slot_clicked.connect(_on_slot_clicked)
		slots.append(slot)

func _load_starting_items():
	var sword = Item.new()
	sword.item_name = "Espada"
	sword.icon = preload("res://weapons/001.png")
	sword.item_type = "weapon"
	sword.weapon_index = 0
	add_item(sword)

func add_item(item: Item):
	items.append(item)
	_refresh_slots()

func _refresh_slots():
	for i in slots.size():
		if i < items.size():
			slots[i].set_item(items[i])
		else:
			slots[i].set_item(null)

func _on_slot_clicked(slot):
	if slot.item == null:
		return
	if slot.item.item_type == "weapon" and player_ref:
		player_ref.equip(slot.item.weapon_index)
		print("Equipado: ", slot.item.item_name)

func _unhandled_input(event):
	if event.is_action_pressed("inventory"):
		toggle_menu()

func toggle_menu():
	is_open = !is_open
	if is_open:
		show()
		anim_player.play("open_book")
		get_tree().paused = true
	else:
		anim_player.play_backwards("open_book")
		get_tree().paused = false
		await anim_player.animation_finished
		hide()
