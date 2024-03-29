extends CanvasLayer
#use showMenu() and hideMenu() to control whether the menu is active on screens
	#default menu state is set in _ready()

var animating = false
var shown = false
var settingsShown = false
var creditsShown = false


func _ready():
	#set menu to default view
	$Menu.hide()
	$SettingsMenu.menu_node = self
	$SettingsMenu.hide()
	$Credits.menu_node = self
	$Credits.hide()


#menu state func below

func showMenu():
	#pause game on menu load and show menu
	
	get_tree().paused = true
	$Menu.show()
	shown = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$Menu/MarginContainer/MarginContainer/VBoxContainer/ResumeBtn.grab_focus()


func hideMenu():
	#hide menu and trigger settings to save to user config, unpause game
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	if settingsShown:
		hide_settings()
	
	if creditsShown:
		hide_credits()
	
	var error = SettingsManager.save_config() 
	if error != OK:
		printerr("Failure!")
	
	$Menu.hide()
	shown = false
	get_tree().paused = false


#inner menu func below

func show_settings():
	$SettingsMenu.show()
	$SettingsMenu/MarginContainer/MarginContainer/VBoxContainer2/MarginContainer/VBoxContainer/MasterAudio.grab_focus()
	settingsShown = true


func hide_settings():
	$SettingsMenu.hide()
	settingsShown = false
	$Menu/MarginContainer/MarginContainer/VBoxContainer/ResumeBtn.grab_focus()


func show_credits():
	$Credits.show()
	$Credits/MarginContainer/MarginContainer/VBoxContainer2/MarginContainer/VBoxContainer/ScrollContainer.grab_focus()
	creditsShown = true


func hide_credits():
	$Credits.hide()
	creditsShown = false
	$Menu/MarginContainer/MarginContainer/VBoxContainer/ResumeBtn.grab_focus()


func _unhandled_input(event):
	if Input.is_action_just_released("start_menu"):
		if shown == true:
			hideMenu()
		else:
			showMenu()
	elif Input.is_action_just_released("ui_cancel"):
		if shown == true and settingsShown == false and creditsShown == false:
			hideMenu()
		elif settingsShown == true:
			hide_settings()
		elif creditsShown == true:
			hide_credits()
