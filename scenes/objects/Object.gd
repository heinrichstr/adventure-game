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
var objectState = objectStates.CLOSED

enum objectStates {CLOSED, PROMPT, OPEN}

signal object_menu_toggle(toggleState, objectMenu, fromNode)


func _ready():
	var actionIndex = 0
	for action in actions.values():
		if action == true:
			actionRefs.push_back(References.objectActions[actions.keys()[actionIndex]])
		actionIndex += 1
	prints('actionsList', actionRefs)
	
	#$Control/ObjectMenu.actions = actionRefs
	#$Control/ObjectMenu.build_menu()
	#$Control/ObjectMenu.place_buttons()
	#connect("object_menu_toggle", Actions._on_object_menu_toggle)



func _unhandled_input(event):
#Grab button inputs. Make sure it is a button press. Pass that button press onwards to the function that handles is

	if event is InputEventJoypadButton:
		if interactable:
			if Input.is_action_just_pressed("input"):
				_on_button_pressed("left")
			elif Input.is_action_just_pressed("input_top"):
				_on_button_pressed("top")
			elif Input.is_action_just_pressed("input_right"):
				_on_button_pressed("right")


func _on_button_pressed(btn):
	#Take in button press, handle logic of what to do with it
	
	prints("btn press", btn)
	if References.dialog.in_progress == false && objectState == objectStates.PROMPT:
		if btn == "left":
			objectState = objectStates.OPEN
			$Interactable.open_options()
	elif References.dialog.in_progress == false && objectState == objectStates.OPEN:
		if btn == "left":
			print('gettem')


func _on_area_2d_area_entered(area):
	if area == References.player.get_node("PlayerArea2D"):
		$Interactable.open_interact("PROMPT")
		interactable = true
		objectState = objectStates.PROMPT
		References.activeObject = self


func _on_area_2d_area_exited(area):
	$Interactable.close_interact("PROMPT")
	interactable = false
	objectState = objectStates.CLOSED
	References.activeObject = null

