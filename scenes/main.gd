extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	References.world = $World
	Input.set_custom_mouse_cursor(References.default_cursor)
	
	#DisplayServer.window_set_size(Vector2i(1240, 1080))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
