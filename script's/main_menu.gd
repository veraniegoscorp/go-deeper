extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$background_menu.play("default")
	await $background_menu.animation_finished
	$menu_pagina1.show()
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(_delta):
	# Ajustamos la escala dependiendo de la animación activa
	if $background_menu.animation == "next_page":
		$background_menu.scale = Vector2(4.5, 4.5) # La agrandas al doble
		$background_menu.position.y = 328
		
	# Ajustamos la escala dependiendo de la animación activa
	if $background_menu.animation == "previus_page":
		$background_menu.scale = Vector2(4.5, 4.5) # La agrandas al doble
		$background_menu.position.y = 328
		
		
	elif $background_menu.animation == "default":
		$background_menu.scale = Vector2(1.5, 1.5) # La dejas normal


func _on_div_settings_pressed() -> void:
	$background_menu.play("next_page")
	$menu_pagina1.hide()
	await $background_menu.animation_finished
	$menu_opciones1.show()


func _on_return_to_menu_pressed() -> void:
	$background_menu.play("previus_page")
	$menu_opciones1.hide()
	await $background_menu.animation_finished
	$menu_pagina1.show()


func _on_div_nuevo_juego_pressed() -> void:
	get_tree().change_scene_to_file("res://tcnes/animation_on_start.tscn")
