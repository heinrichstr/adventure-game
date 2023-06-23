extends Node2D
#Container that loads in the forage game

var brushed_count = 0
var plant_count
var overlay_forage_key
var overlay_forage_target
var velocity = Vector2(0,0)
var active = false
var joystickInput = false
var input_vector_temp

func _ready():
	References.forageOverlay = self


func _unhandled_input(event):
	if active == true:
		if Actions.player_input(event) == "motion":
			var down = Input.get_action_strength("gamepad_down")
			var up = Input.get_action_strength("gamepad_up")
			var left = Input.get_action_strength("gamepad_left")
			var right = Input.get_action_strength("gamepad_right")
			
			if down > 0.5 or up > 0.5 or left > 0.5 or right > 0.5:
				joystickInput = true
				
			if joystickInput == true:
				input_vector_temp = Input.get_vector("gamepad_left","gamepad_right","gamepad_up","gamepad_down")
			else:
				input_vector_temp = Vector2.ZERO
		
			input_vector_temp = input_vector_temp.normalized()*50
			velocity = input_vector_temp


func _physics_process(delta):
	if active == true:
		get_viewport().warp_mouse(get_viewport().get_mouse_position() + velocity)


func show_overlay(forage_key, forage_target): 
	print("FORAGING")
	#handles moving the forage screen in and setting up the screen
	
	#prints("received key", forage_key, "for target", forage_target)
	overlay_forage_key = forage_key
	overlay_forage_target = forage_target
	Actions.playerInput = false
	active = true
	$BackgroundColor.modulate = Color(0,0,0,1)
	$TargetPlant.reset()
	load_forage(forage_key)
	var tw = create_tween().set_parallel().set_trans(1).set_ease(1)
	tw.tween_property(self, "position", Vector2(0,0), .5)
	tw.tween_property(self, "modulate", Color(1, 1, 1, 1), .5)
	await tw.finished
	var btn_tw = create_tween().set_parallel().set_trans(1).set_ease(1)
	btn_tw.tween_property($TextureButton, "modulate", Color(1, 1, 1, 1), .25)
	await btn_tw.finished
	Actions.playerInput = true
	Actions.worldInput = false


func hide_overlay():
	#hides and resets the overlay, including unloading the forage items
	
	Actions.playerInput = false
	var tw = create_tween().set_parallel().set_trans(1).set_ease(1)
	tw.tween_property(self, "position", Vector2(0,1100), .5)
	tw.tween_property(self, "modulate", Color(0, 0, 0, 1), .5)
	tw.tween_property($TextureButton, "modulate", Color(1, 1, 1, 0), .25)
	brushed_count = 0
	plant_count = 0
	$ForageEndScreen.fade_out()
	
	await tw.finished
	
	Input.set_custom_mouse_cursor(References.default_cursor)
	Actions.playerInput = true
	Actions.worldInput = true
	for n in $Forage.get_children():
		$Forage.remove_child(n)
		n.queue_free()


func load_forage(forage_key:String):
	#loads in which forage overlay to use
	#TODO also load in the herb sprite and set the target plant to that herb
	
	var instancePath = References.forages[forage_key]
	var forageInstance = load(instancePath)
	var forage = forageInstance.instantiate()
	$Forage.add_child(forage)
	plant_count = $Forage.get_child(0).get_child_count()
	$TargetPlant.texture = load(References.forage_targets[overlay_forage_target])
	$ForageEndScreen/VBoxContainer/Sprite2D.texture = load(References.forage_targets[overlay_forage_target])


func handle_plant_state_update():
	#Called via signal by Actions
	#Slowly reveals the herb and background
	
	if brushed_count <= plant_count:
		var colorBalance = float(brushed_count)/float(plant_count)
		$BackgroundColor.modulate = Color(colorBalance,colorBalance,colorBalance,1)
		$TargetPlant.modulate = Color(colorBalance*.5,colorBalance*.5,colorBalance*.5,colorBalance)
	if brushed_count == plant_count:
		$TargetPlant.set_active()
		$TargetPlant.modulate = Color(1,1,1,1)


func finish_game():
	print("game finish")
	$ForageEndScreen.fade_in()
	#Show herb picked UI
		#include shiny sprite
		#include btn to add to inventory
