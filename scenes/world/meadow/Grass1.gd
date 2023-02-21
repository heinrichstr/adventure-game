extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	self.material.set_shader_parameter("offset", self.global_position.x/800)
	print(material["shader_parameter/offset"])
