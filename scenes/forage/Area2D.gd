extends Area2D

var moused = false
var brushed_aside = false
@export var left = false
@export var colorBase = 0.9

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.material.set_shader_parameter("offset", self.global_position.x/400)
	self.modulate = Color(colorBase,colorBase,colorBase,1)
	if self.global_position.x > 950:
		left = false
	else: 
		left = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_mouse_entered():
	if brushed_aside == false:
		Input.set_custom_mouse_cursor(References.hand_cursor)
		moused = true


func _on_mouse_exited():
	#elf.modulate = Color(colorBase-0.1,colorBase-0.1,colorBase-0.1,1)
	moused = false


func highlight():
	self.modulate = Color(colorBase,colorBase,colorBase,1)


func lowlight():
	self.modulate = Color(colorBase-0.2,colorBase-0.2,colorBase-0.2,1)

