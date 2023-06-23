extends CenterContainer

var actionList
var buttonNode = preload("res://scenes/ui/InteractionButton.tscn")
var buttonList = []
var interactableNode
var activeBtn

@onready var listNode = $MarginContainer/MarginContainer/CenterContainer/VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	self.position = Vector2(self.size.y*.2,self.size.x*.2)
	self.scale = Vector2(.6,.6)
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func show_menu(actions):
	prints("yup", actions)
	actionList = actions
	buttonList = []
	
	#put buttons in listNode with desc and connect signals to actions
	for action in actionList:
		print(action.desc)
		var newButton = buttonNode.instantiate()
		newButton.text = action.desc
		newButton.pressed.connect(action.signal_call)
		buttonList.push_back(newButton)
		listNode.add_child(newButton)
	
	#Below sets tab order for buttons programmatically
	var index = 0
	for button in buttonList:
		if index == 0:
			button.focus_neighbor_top = buttonList[buttonList.size() - 1].get_path()
			button.focus_previous = buttonList[buttonList.size() - 1].get_path()
			button.focus_neighbor_bottom = buttonList[index+1].get_path()
			button.focus_next = buttonList[index+1].get_path()
		
		elif index == buttonList.size() - 1:
			button.focus_neighbor_top = buttonList[index - 1].get_path()
			button.focus_previous = buttonList[index - 1].get_path()
			button.focus_neighbor_bottom = buttonList[0].get_path()
			button.focus_next = buttonList[0].get_path()
		
		else:
			button.focus_neighbor_top = buttonList[index - 1].get_path()
			button.focus_previous = buttonList[index - 1].get_path()
			button.focus_neighbor_bottom = buttonList[index + 1].get_path()
			button.focus_next = buttonList[index+1].get_path()
		
		index += 1
	
	buttonList[0].grab_focus()
	
	self.scale = Vector2(.6,0)
	show()
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(.6,.6), .2).set_trans(Tween.TRANS_SINE)
	


func close_menu():
	hide()
	for child in listNode.get_children():
		child.queue_free()
	actionList = []
	buttonList = []


func get_active_btn():
	return(activeBtn)
