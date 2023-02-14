extends Node2D

var toggleState = false
@onready var actions = [References.actions.examine, References.actions.forage, References.actions.examine]
@onready var description = References.dialog.item_descriptions.stick
var forage_key = "meadow-1"
signal object_menu_toggle(toggleState, objectMenu, fromNode)


func _ready():
	$Control/ObjectMenu.actions = actions
	$Control/ObjectMenu.build_menu()
	$Control/ObjectMenu.place_buttons()
	connect("object_menu_toggle", Actions._on_object_menu_toggle)


func _on_button_pressed():
	if References.dialog.in_progress == false:
		emit_signal("object_menu_toggle", toggleState, $Control/ObjectMenu, self)
		toggleState = !toggleState


func _on_button_mouse_entered():
	pass # Replace with function body.


func _on_button_mouse_exited():
	pass # Replace with function body.
