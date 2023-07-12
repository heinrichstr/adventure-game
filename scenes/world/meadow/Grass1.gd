extends AnimatedSprite2D

@export var walkable = true
# Called when the node enters the scene tree for the first time.
func _ready():
	self.material.set_shader_parameter("offset", self.global_position.x/800)
	$Area2D.add_to_group("grass_walkable")

#func _on_area_2d_area_entered(area):
#	if area == References.player.get_node("Area2D"):
#		prints("collision between", self, "and", area)
