extends Node2D

#Variables that config the object

@export var actions = [
	{
		"desc": "Forage",
		"signal_call": func(): _start_forage()
	},
	{
		"desc": "Talk",
		"signal_call": func(): _start_dialog()
	}
]

@export var description:String
@export var forage_key:String
@export var forage_target:String
@export var item_desc_key:String


#Variables set by the code to be used internally
@onready var actionRefs:Array = []

var toggleState = false
var interactable = false

signal object_menu_toggle(toggleState, objectMenu, fromNode)


func _ready():
	var actionIndex = 0
	
	$Interactable.object = self


func _unhandled_input(event):
#Grab button inputs. Make sure it is a button press. Pass that button press onwards to the function that handles is
	if interactable:
		if Actions.player_input(event) == "input":
			_interact("input")
		elif Actions.player_input(event) == "cancel":
			_interact("cancel")


func _interact(inputType):
	if inputType == "input":
		if $Interactable.openState == false:
			Actions.toggle_player_input()
			$Interactable.load_menu(actions)
	elif inputType == "cancel":
		if $Interactable.openState == true:
			Actions.toggle_player_input()
			$Interactable.close_menu()


func _start_forage():
	print("start forage")
	interactable = false
	$Interactable.close_interact("PROMPT")
	Actions._on_forage($Interactable,forage_key, forage_target)
	#References.emit_signal("forage", self, forage_key, forage_target )


func _start_dialog():
	print("start dialog")


func _on_area_2d_area_entered(area):
	if area == References.player.get_node("PlayerArea2D"):
		$Interactable.open_interact("PROMPT")
		interactable = true
		References.activeObject = self


func _on_area_2d_area_exited(area):
	$Interactable.close_interact("PROMPT")
	interactable = false
	References.activeObject = null

