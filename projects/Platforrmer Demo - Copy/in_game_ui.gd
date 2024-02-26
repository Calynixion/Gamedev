extends Control

var active = false
var fps_active = false
var debug_active = false


func _ready():
	$menu.grab_focus()

func _on_menu_pressed():
	if active == true:
		active = false
		$menu.grab_focus()
	else:
		active = true




func _process(_delta):
	if active == false:
		$reset.hide()
		$tint.hide()
		$quit.hide()
		$exit.hide()
		$fps2.hide()
		$debug.hide()
	if active == true:
		$reset.show()
		$tint.show()
		$quit.show()
		$exit.show()
		$fps2.show()
		$debug.show()
	if fps_active == true:
		$fps.show()
	if fps_active == false:
		$fps.hide()
	if debug_active == true:
		$state.show()
		$velocity.show()
	if debug_active == false:
		$state.hide()
		$velocity.hide()

func _on_reset_pressed():
	get_tree().reload_current_scene()


func _on_quit_pressed():
	get_tree().quit()


func _on_exit_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")


func _on_debug_toggled(_toggled_on):
	if debug_active == true:
		debug_active = false
	else:
		debug_active = true



func _on_fps_2_toggled(_toggled_on):
	if fps_active == true:
		fps_active = false
	else:
		fps_active = true
