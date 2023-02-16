extends Sprite2D

var clickable = false
var clickBuffer = false
var clickerCount = 6
signal picked_herb(_from_node)


func _ready():
	connect("picked_herb", Actions._on_picked_herb)


func _unhandled_input(event):
	#handles animation and logic when clicked and allowed to be clicked
	if event.is_action_pressed('click') && clickable:
		if clickBuffer: #prevents firing a click too soon on forage screen
			if clickerCount == 0:
				#launch picked modal
				print("PICKED")
				emit_signal("picked_herb", self)
			
			play_click_anim()
			clickerCount -= 1
		else:
			clickBuffer = true


func play_click_anim(): #handles animating the sprite pos when clicked and particles
	var tw = create_tween().set_trans(1).set_ease(1)
	tw.tween_property(self, "position", Vector2(position.x, position.y + 10), .05)
	tw.tween_property(self, "position", Vector2(position.x, position.y-5), .1)


func set_active():
	clickable = true


func reset(): #called to set back to base
	modulate = Color(1,1,1,0)
	clickable = false
	clickBuffer = false
	position.y = 590
	clickerCount = 6
