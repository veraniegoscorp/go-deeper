extends TextureButton

var item: Item = null
@onready var icon: TextureRect = $Icon

signal slot_clicked(slot)

func _ready():
	pressed.connect(_on_pressed)

func set_item(new_item: Item):
	item = new_item
	if item:
		icon.texture = item.icon
		icon.show()
	else:
		icon.texture = null
		icon.hide()

func _on_pressed():
	slot_clicked.emit(self)
