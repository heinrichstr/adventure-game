extends CanvasLayer


var scene_text = []
var text_key = 0
var in_progress = false
var writing_text = false

func _ready():
	$Background.visible = false
	References.dialog = self


func start_dialog(dialog_text:Array, key:int): 
	#Called by Actions to start showing dialog
	#includes argument for the array of dialog and a key to tell the player where to start
	
	scene_text = dialog_text
	text_key = key
	$Area2D.show() #handles gathering input from user to move scene forward when in dialog
	display_dialog()


func display_dialog():
	#handles the logic of displaying the dialog text
	#Starts showing the dialog with show_text() if dialog is starting. Otherwise, if in progress then it moves to the next line
	
	if in_progress:
		next_line()
	else:
		#get_tree().paused = true
		$Background.visible = true
		in_progress = true
		show_text()


func show_text():
	#Handles animating the text in the dialog
	
	#set up the starting opacity and hide the indicator
	writing_text = true
	$DialogStatusIndicator.modulate = Color(1, 1, 1, 0)
	$TextLabel.visible_ratio = 0
	$TextLabel.text = scene_text[text_key]
	
	#write the text to the dialog box
	var tw = create_tween().set_trans(0).set_ease(1)
	tw.tween_property($TextLabel, "visible_ratio", 1, 1)
	
	#animate the indicator when text is finished writing to the screen
	await tw.finished
	writing_text = false
	#decide which indicator to use
	if text_key + 1 == scene_text.size():
		$DialogStatusIndicator.play("complete")
	else:
		print("progress")
		$DialogStatusIndicator.play("progress")
	#fade the indicator in
	var indicatorTween = create_tween().set_trans(0).set_ease(1)
	indicatorTween.tween_property($DialogStatusIndicator, "modulate", Color(1, 1, 1, 1), .15)


func next_line():
	#moves the scene_text to the next key in the array
	#if the scene is complete, finish the dialog box
	
	$DialogStatusIndicator.modulate = Color(1, 1, 1, 0)
	text_key += 1
	if text_key >= scene_text.size():
		finish()
	else:
		show_text()


func finish():
	#resets the dialog box back to it's starting values so it is ready to receive the next text
	
	$TextLabel.text = ""
	text_key = 0
	$Background.visible = false
	in_progress = false
	$Area2D.hide()
	get_tree().paused = false


func _on_area_2d_input_event(_viewport, event, _shape_idx):
	#move the text forward if a click is registered to the screen
	
	if event.is_action_pressed('click'):
		if References.dialog.in_progress:
			References.dialog.display_dialog()
