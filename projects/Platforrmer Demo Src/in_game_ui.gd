extends Control

var active = false

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
	if active == true:
		$reset.show()
		$tint.show()
		$quit.show()
		$exit.show()


func _on_reset_pressed():
	get_tree().reload_current_scene()


func _on_quit_pressed():
	get_tree().quit()


func _on_exit_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")
