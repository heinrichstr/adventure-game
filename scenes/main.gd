extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	References.world = $World
	References.game_node = self
	$AudioStreamPlayer.playing = true
	Input.set_custom_mouse_cursor(References.default_cursor)
	
	#DisplayServer.window_set_size(Vector2i(1240, 1080))


func _on_menu_btn_pressed():
	if $MainMenu.shown:
		$MainMenu.hideMenu()
	else:
		$MainMenu.showMenu()

func _physics_process(delta):
	#Hide cursor when moving
	
	if References.State.keyboard == false:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	elif References.State.keyboard == true:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _unhandled_input(event):
	if event is InputEventMouseMotion:
		References.State.keyboard = true
	#if (event is InputEventJoypadButton) or (event is InputEventJoypadMotion and Input.get_action_strength()):
	#	References.State.keyboard = false
