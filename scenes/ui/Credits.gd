extends CenterContainer


var menu_node
@onready var scrollContainer = $MarginContainer/MarginContainer/VBoxContainer2/MarginContainer/VBoxContainer/ScrollContainer

func _on_texture_button_pressed():
	menu_node.hide_credits()


func _input(event):
	if menu_node.creditsShown:
		if Input.is_action_just_pressed("ui_down"):
			prints('scrolldown', scrollContainer.scroll_vertical)
			scrollContainer.scroll_vertical += 50
		elif Input.is_action_just_pressed("ui_up"):
			prints('scrollup', scrollContainer.scroll_vertical)
			scrollContainer.scroll_vertical -= 50
