extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	References.world = $World
	References.game_node = self
	$AudioStreamPlayer.playing = true
	Input.set_custom_mouse_cursor(References.default_cursor)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	#DisplayServer.window_set_size(Vector2i(1240, 1080))


func _on_menu_btn_pressed():
	if $MainMenu.shown:
		$MainMenu.hideMenu()
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		$MainMenu.showMenu()


func _unhandled_input(event):
	if event is InputEventMouseMotion:
		References.State.keyboard = true
	#if (event is InputEventJoypadButton) or (event is InputEventJoypadMotion and Input.get_action_strength()):
	#	References.State.keyboard = false


func _input(event):
	#handle setting if keyboard or mouse
		if event is InputEventJoypadButton: #if gamepad button pressed
			References.joyPadInputDetection = true
			
		elif event is InputEventJoypadMotion: #if gamepad joystick moved above deadzone
			var down = Input.get_action_strength("gamepad_down")
			var up = Input.get_action_strength("gamepad_up")
			var left = Input.get_action_strength("gamepad_left")
			var right = Input.get_action_strength("gamepad_right")
			if down > 0.2 or up > 0.2 or left > 0.2 or right > 0.2: #custom deadzone values
				References.joyPadInputDetection = true
			
		elif event is InputEventKey or event is InputEventMouse or event is InputEventMouseMotion: #if mouse or keyboard
			References.joyPadInputDetection = false
		
		Actions.update_icons_signal()
