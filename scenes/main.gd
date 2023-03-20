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
