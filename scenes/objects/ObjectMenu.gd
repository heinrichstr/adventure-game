extends Control

#TODO: Package the button scene to dynamically add it based on what the object sets for actions
	#get scale under control I can't read shit in these button labels
	

var button_radius = 40 #in godot position units
var radial_width = 40 #in godot position units

func _ready():
	place_buttons()
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


#Repositions the buttons
func place_buttons():
	var buttons = get_children()

	#Stop before we cause problems when no buttons are available
	if buttons.size() == 0:
		return

	#Amount to change the angle for each button
	var angle_offset = (2 * PI)/buttons.size() #in degrees

	#adjust the starting point so the menu is centered over the object
	var angle = PI/2 - angle_offset * (buttons.size()/2) #in radians
	
	var count = 0
	for btn in buttons: 
		btn.find_child("RichTextLabel").text = str(count)
		count += 1
		#calculate the x and y positions for the button at that angle
			#add half the size of the menu to center on the menu
		var x = cos(angle)*button_radius + self.size.x/2
		var y = (sin(angle)*button_radius + self.size.y/2)/4 + 30 #/2 to flatten out the circle, add a flat amount to make up the difference the flattening causes

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
