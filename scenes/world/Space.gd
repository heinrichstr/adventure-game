extends Node2D

var target = Vector2()
signal click_on_space(target)

func _ready():
	connect("click_on_space", Actions._on_click_on_space)

func _input(event):
	if event.is_action_pressed('click'):
		target = get_global_mouse_position()
		emit_signal("click_on_space", target)
