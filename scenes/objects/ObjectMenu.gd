extends Control


func _ready():
	self.scale = Vector2(0,0)
	self.modulate = Color(1, 1, 1, 0)
	hide()

func show_menu():
	show()
	var tw = create_tween().set_parallel().set_trans(1).set_ease(1)
	tw.tween_property(self, "scale", Vector2(1,1), 0.25)
	tw.tween_property(self, "modulate", Color(1, 1, 1, 1), 0.25)


func hide_menu():
	var tw = create_tween().set_parallel().set_trans(1).set_ease(1)
	tw.tween_property(self, "scale", Vector2(0,0), 0.25)
	tw.tween_property(self, "modulate", Color(1, 1, 1, 0), 0.25)
	await tw.finished
	hide()
