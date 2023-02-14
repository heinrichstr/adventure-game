extends TextureButton

var emitter = func(): pass
var buttonType
@onready var object_node = get_parent().object_node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	if buttonType == "FORAGE":
		emitter.call(self, object_node.forage_key)
	else: 
		emitter.call(self)


func set_text(text):
	#$RichTextLabel.bbcode_text = "[center]" + text + "[/center]"
	tooltip_text = text
