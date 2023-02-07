extends Node2D

var toggleState = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_button_pressed():
	if toggleState:
		print('hide')
		$Control/ObjectMenu.hide()
	else:
		print('show')
		$Control/ObjectMenu.show()
	toggleState = !toggleState

func _on_button_mouse_entered():
	pass # Replace with function body.


func _on_button_mouse_exited():
	pass # Replace with function body.
