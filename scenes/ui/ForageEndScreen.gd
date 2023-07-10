extends CenterContainer


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func fade_in():
	show()
	var tw = create_tween().set_parallel().set_trans(1).set_ease(1)
	tw.tween_property(self, "modulate", Color(1,1,1,1), 0.5)
	tw.tween_property(self, "position", Vector2(position.x, 540), 0.5)
	$VBoxContainer/TextureButton.grab_focus()


func fade_out():
	var tw = create_tween().set_trans(1).set_ease(1)
	tw.tween_property(self, "modulate", Color(1,1,1,0), .5)
	
	await tw
	
	hide()
	position.y = 500


func _on_texture_button_pressed():
	Actions._on_forage_add_to_inventory(References.forageOverlay.overlay_forage_target, self)
