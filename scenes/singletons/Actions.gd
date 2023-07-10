extends Node2D

@onready var default_2d_map_rid : RID = get_world_2d().get_navigation_map()
var playerInput = true #can players provide inputs to the game?
var worldInput = true

signal update_icons()

func _ready():
	pass # Replace with function body.


func update_icons_signal():
	emit_signal("update_icons")


func _process(_delta):
	#used to "pause" player input globablly, set by toggle_player_input()
	if playerInput == true:
		References.player.set_process_unhandled_input(true)
		References.player.set_physics_process(true)
	elif playerInput == false:
		References.player.set_process_unhandled_input(false)
		References.player.set_physics_process(false)


func toggle_player_input():
	playerInput = not playerInput


func player_input(event):
	if event is InputEventJoypadButton:
		#TODO: set key icons to joypad
		if Input.is_action_just_pressed("input"):
			return("input")
		elif Input.is_action_just_pressed("cancel"):
			return("cancel")
		elif Input.is_action_just_pressed("bumper_left"):
			return("bumper_left")
		elif Input.is_action_just_pressed("bumper_right"):
			return("bumper_right")
	elif event is InputEventKey:
		#TODO: set key icons to keyboard input
		if Input.is_action_just_pressed("input"):
			return("input")
		elif Input.is_action_just_pressed("cancel"):
			return("cancel")
		elif Input.is_action_just_pressed("bumper_left"):
			return("bumper_left")
		elif Input.is_action_just_pressed("bumper_right"):
			return("bumper_right")
	elif event is InputEventJoypadMotion:
		return("motion")


func _on_object_menu_toggle(toggleState, object_menu, from_node): #Object node emit
#called when user clicks on an object
#shows or hides the menu
	if References.dialog.in_progress == false:
		if (playerInput == true):
			if(toggleState):
				#object_menu.hide_menu() #replace with tween
				from_node.get_node("Interactable").close_interact()
			else:
				#object_menu.show_menu() #replace with tween
				from_node.get_node("Interactable").open_interact()


func _on_examine(object_menu_btn): #References node emit from object menu click
	if (playerInput == true && worldInput == true):
		#prints(object_menu_btn.buttonType, " | ", object_menu_btn.object_node.description)
		object_menu_btn.object_node.toggleState = !object_menu_btn.object_node.toggleState
		object_menu_btn.get_parent().hide_menu()
		#pass dialog text array to dialogbox and tell it to start
		References.dialog.start_dialog(object_menu_btn.object_node.description, 0)


func _on_forage(object_interactable, forage_key, forage_target): #References node emit from object menu click
	#prints(object_menu_btn.buttonType, " | ", object_menu_btn.object_node.description, forage_key)
	#object_menu_btn.object_node.toggleState = !object_menu_btn.object_node.toggleState
	#object_menu_btn.get_parent().hide_menu()
	object_interactable.close_menu()
	References.forageOverlay.show_overlay(forage_key, forage_target)
	


func _on_forage_overlay_close_btn():
	References.forageOverlay.hide_overlay()


func _on_clicked_plant(_from_node):
	References.forageOverlay.brushed_count += 1
	References.forageOverlay.handle_plant_state_update()


func _on_picked_herb(_from_node):
	Input.set_custom_mouse_cursor(References.default_cursor)
	References.forageOverlay.finish_game()


func _on_forage_add_to_inventory(forage_target, _from_node):
	print("closeout", forage_target)
	References.forageOverlay.hide_overlay()
	References.get_node("State").inventory_state.herb_bag.contents.push_back(forage_target)
	#add to inventory


func _on_space_switcher(to_space_string_id):
	prints("move to space", to_space_string_id)
	References.spaceSwitcher_node.replaceScene(to_space_string_id)
