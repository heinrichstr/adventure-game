extends Node2D


#func _unhandled_input(event):
#	if event.is_action_pressed('click'):
#		if References.dialog.in_progress == false:
#			target = get_global_mouse_position()
#			emit_signal("click_on_space", target, self)


func _on_movement_input(velocity:Vector2):
	print("movement input")
	print("sending data to Player node")
	print(velocity)


func _unhandled_input(event):
	var player_velocity = Vector2.ZERO
	
	if event.is_action_pressed('player_up'):
		player_velocity.y -= 1
	if event.is_action_pressed('player_down'):
		player_velocity.y += 1
	if event.is_action_pressed('player_left'):
		player_velocity.x -= 1
	if event.is_action_pressed('player_right'):
		player_velocity.x += 1
		
	player_velocity = player_velocity.normalized()
	_on_movement_input(player_velocity)
