extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("pressed", Actions._on_forage_overlay_close_btn)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
