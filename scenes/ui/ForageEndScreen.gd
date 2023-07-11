extends CanvasLayer

var ui_size

func fade_in():
	
	ui_size = References.world.get_viewport().size
	offset = Vector2((ui_size.x/2) - ($MarginContainer.size.x /2), ui_size.y + 100)
	
	show()
	prints($MarginContainer.size)
	var tw = create_tween().set_parallel().set_trans(1).set_ease(1)
	tw.tween_property($MarginContainer, "modulate", Color(1,1,1,1), 0.5)
	tw.tween_property(self, "offset", Vector2((ui_size.x/2) - ($MarginContainer.size.x /2), (ui_size.y/2) - ($MarginContainer.size.y/2)), 0.5)
	$MarginContainer/VBoxContainer/TextureButton.grab_focus()


func fade_out():
	#var tw = create_tween().set_trans(1).set_ease(1)
	#tw.tween_property($MarginContainer, "modulate", Color(1,1,1,0), .5)
	
	#await tw.finished
	self.hide()


func _on_texture_button_pressed():
	Actions._on_forage_add_to_inventory(References.forageOverlay.overlay_forage_target, self)
