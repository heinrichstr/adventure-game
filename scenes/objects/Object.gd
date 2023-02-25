extends Node2D

#Variables that config the object
@export var actions = {
	"examine": true,
	"forage": true,
	"talk": true,
	"interact": true
}
@export var forage_key:String
@export var forage_target:String
@export var item_desc_key:String

#Variables set by the code to be used internally
@onready var actionRefs:Array = []
@onready var description = References.dialog.item_descriptions.stick
var toggleState = false
var interactable = false

signal object_menu_toggle(toggleState, objectMenu, fromNode)


func _ready():
	var actionIndex = 0
	for action in actions.values():
		if action == true:
			actionRefs.push_back(References.objectActions[actions.keys()[actionIndex]])
		actionIndex += 1
	prints('actionsList', actionRefs)
	
	$Control/ObjectMenu.actions = actionRefs
	$Control/ObjectMenu.build_menu()
	$Control/ObjectMenu.place_buttons()
	connect("object_menu_toggle", Actions._on_object_menu_toggle)


func _on_button_pressed():
	if References.dialog.in_progress == false:
		emit_signal("object_menu_toggle", toggleState, $Control/ObjectMenu, self)
		toggleState = !toggleState


func _on_area_2d_area_entered(area):
	if area == References.player.get_node("PlayerArea2D"):
		$Interactable.open_interact()
		interactable = true
		References.activeObject = self
		prints("active? ", References.activeObject)


func _on_area_2d_area_exited(area):
	$Interactable.close_interact()
	interactable = false
	References.activeObject = null
	prints("active? ", References.activeObject)
