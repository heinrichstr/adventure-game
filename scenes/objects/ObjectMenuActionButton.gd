extends TextureButton

var emitter = func(): pass
var buttonType
@onready var object_node = get_parent().object_node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	emitter.call(self)


func set_text(text):
	#$RichTextLabel.bbcode_text = "[center]" + text + "[/center]"
	tooltip_text = text
