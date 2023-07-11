extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("pressed", Actions._on_forage_overlay_close_btn)
