extends Node2D


var activePlants = []
var top_plant
var top_plant_z = -1
signal clicked_plant(_from_node)

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("clicked_plant", Actions._on_clicked_plant)


func _unhandled_input(event):
	#if clicked, interact with the plant on top under the mouse
	if event.is_action_pressed('click') && top_plant:
		if top_plant.left == true:
			top_plant.get_node("AnimatedSprite2D").frame = 1
			top_plant.brushed_aside = true
		else:
			top_plant.get_node("AnimatedSprite2D").frame = 2
			top_plant.brushed_aside = true
		
		top_plant = null
		emit_signal("clicked_plant", self)
	
	#if not click, decide which plant under the mouse is on top
	else:
		#reset ordering
		activePlants = []
		top_plant_z = -1
		
		for c in get_children():
			#build list of active plants
			c.lowlight()
			if c.moused && c.brushed_aside == false:
				activePlants.push_back(c)
		
		for activePlant in activePlants:
			#get top plant
			if activePlant.z_index > top_plant_z:
				top_plant = activePlant
		
		if top_plant:
			top_plant.highlight()
