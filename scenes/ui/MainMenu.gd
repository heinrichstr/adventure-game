extends Control
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


func hideMenu():
	#hide menu and trigger settings to save to user config, unpause game
	
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
	settingsShown = true


func hide_settings():
	$SettingsMenu.hide()
	settingsShown = false


func show_credits():
	$Credits.show()
	creditsShown = true


func hide_credits():
	$Credits.hide()
	creditsShown = false
