extends Node2D

var toggleState = false
signal object_menu_toggle(toggleState, objectMenu, fromNode)


func _ready():
	connect("object_menu_toggle", Actions._on_object_menu_toggle)


func _on_button_pressed():
	emit_signal("object_menu_toggle", toggleState, $Control/ObjectMenu, self)
	toggleState = !toggleState


func _on_button_mouse_entered():
	pass # Replace with function body.


func _on_button_mouse_exited():
	pass # Replace with function body.
