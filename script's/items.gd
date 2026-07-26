extends Resource
class_name Item

@export var item_name: String
@export var icon: Texture2D
@export var item_type: String = "weapon" # "weapon" o "misc"
@export var weapon_index: int = -1 # índice en el array de weapons de center_weapons
