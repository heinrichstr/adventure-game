extends AnimatedSprite2D


@export var actionType:String
var joypadActiveState = true

# Called when the node enters the scene tree for the first time.
func _ready():
	Actions.update_icons.connect(self.remap_sprites)
	remap_sprites()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func remap_sprites():
	if References.joyPadInputDetection:
		joypadActiveState = true
	elif References.joyPadInputDetection == false:
		joypadActiveState = false
	
	if actionType == "input":
		if joypadActiveState == true:
			frame = 7
		elif joypadActiveState == false:
			frame = 2
	elif actionType == "cancel":
		if joypadActiveState == true:
			frame = 1
		elif joypadActiveState == false:
			frame = 9
	elif actionType == "forage_right":
		if joypadActiveState == true:
			frame = 11
		elif joypadActiveState == false:
			frame = 0
	elif actionType == "forage_left":
		if joypadActiveState == true:
			frame = 12
		elif joypadActiveState == false:
			frame = 1
