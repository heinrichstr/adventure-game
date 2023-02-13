extends CanvasLayer


var scene_text = []
var text_key = 0
var in_progress = false
var writing_text = false

func _ready():
	$Background.visible = false
	References.dialog = self


func start_dialog(dialog_text, key):
	prints("starting dialog", key, dialog_text)
	scene_text = dialog_text
	text_key = key
	$Area2D.show()
	display_dialog()


func display_dialog():
	if in_progress:
		next_line()
	else:
		#get_tree().paused = true
		$Background.visible = true
		in_progress = true
		show_text()


func show_text():
	writing_text = true
	$DialogStatusIndicator.modulate = Color(1, 1, 1, 0)
	$TextLabel.visible_ratio = 0
	$TextLabel.text = scene_text[text_key]
	var tw = create_tween().set_trans(0).set_ease(1)
	tw.tween_property($TextLabel, "visible_ratio", 1, 1)
	await tw.finished
	writing_text = false
	if text_key + 1 == scene_text.size():
		$DialogStatusIndicator.play("complete")
	else:
		print("progress")
		$DialogStatusIndicator.play("progress")
	var indicatorTween = create_tween().set_trans(0).set_ease(1)
	indicatorTween.tween_property($DialogStatusIndicator, "modulate", Color(1, 1, 1, 1), .15)


func next_line():
	$DialogStatusIndicator.modulate = Color(1, 1, 1, 0)
	text_key += 1
	if text_key >= scene_text.size():
		finish()
	else:
		show_text()


func finish():
	$TextLabel.text = ""
	text_key = 0
	$Background.visible = false
	in_progress = false
	$Area2D.hide()
	get_tree().paused = false


func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed('click'):
		if References.dialog.in_progress:
			References.dialog.display_dialog()