extends CenterContainer

var actionList
var buttonNode = preload("res://scenes/ui/InteractionButton.tscn")

@onready var listNode = $MarginContainer/MarginContainer/VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func show_menu(actions):
	prints("yup", actions)
	actionList = actions
	
	#put buttons in listNode with desc and connect signals to actions
	for action in actionList:
		print(action.desc)
		var newButton = buttonNode.instantiate()
		newButton.text = action.desc
		newButton.pressed.connect(action.signal_call)
		listNode.add_child(newButton)
	
	show()
