extends Area2D

var moused = false
var brushed_aside = false
@export var colorBase = 0.9

# Called when the node enters the scene tree for the first time.
func _ready():
	self.modulate = Color(colorBase,colorBase,colorBase,1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_mouse_entered():
	self.modulate = Color(colorBase + .1,colorBase + .1,colorBase + .1,1)
	moused = true


func _on_mouse_exited():
	self.modulate = Color(colorBase,colorBase,colorBase,1)
	moused = false


func _on_input_event(viewport, event, shape_idx):
	if event.is_action_pressed('click') && moused:
		brushed_aside = true
