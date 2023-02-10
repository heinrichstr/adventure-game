extends Control

var button_radius = 30 #in godot position units
var radial_width = 20 #in godot position units

func _ready():
	place_buttons()
	self.scale = Vector2(0,0)
	self.modulate = Color(1, 1, 1, 0)
	hide()

func show_menu():
	print('show')
	show()
	var tw = create_tween().set_parallel().set_trans(1).set_ease(1)
	tw.tween_property(self, "scale", Vector2(1,1), 0.25)
	tw.tween_property(self, "modulate", Color(1, 1, 1, 1), 0.25)


func hide_menu():
	print('hide')
	var tw = create_tween().set_parallel().set_trans(1).set_ease(1)
	tw.tween_property(self, "scale", Vector2(0,0), 0.25)
	tw.tween_property(self, "modulate", Color(1, 1, 1, 0), 0.25)
	await tw.finished
	hide()


#Repositions the buttons
func place_buttons():
	var buttons = get_children()

	#Stop before we cause problems when no buttons are available
	if buttons.size() == 0:
		return

	#Amount to change the angle for each button
	var angle_offset = (0.7 * PI)/buttons.size() #in degrees

	#adjust the starting point so the menu is centered over the object
	var angle = PI/2 - angle_offset * (buttons.size()/2) #in radians
	
	var count = 0
	for btn in buttons: 
		btn.find_child("RichTextLabel").text = str(count)
		count += 1
		#calculate the x and y positions for the button at that angle
		var x = cos(angle)*button_radius
		var y = sin(angle)*button_radius

		#set button's position
		#>we want to center the element on the circle. 
		#>to do this we need to offset the calculated x and y respectively by half the height and width
		var corner_pos = Vector2(x, -y)-(btn.get_size()/2) #Screen coordinates so calculated y must be negated
		btn.set_position(corner_pos)

		#Advance to next angle position
		angle += angle_offset


#utility function for adding buttons and recalculating their positions
#TODO: Should probably just use a signal to run place_button on any tree change
func add_button(btn):
	add_child(btn)
	place_buttons()
