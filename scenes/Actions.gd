extends Node2D

@onready var default_2d_map_rid : RID = get_world_2d().get_navigation_map()
var playerInput = true #can players provide inputs to the game?
var worldInput = true

func _ready():
	pass # Replace with function body.


func _process(_delta):
	pass


func _on_click_on_space(target, _from_node): #Space node emit
# called when user clicks on the screen to move the character
# creates an array of Vector2() paths navigating with the navmesh of the Space
# setting the target on the player causes the player to move
	if (playerInput == true && worldInput == true):
		References.player.path = NavigationServer2D.map_get_path(
			default_2d_map_rid,
			References.player.position,
			target,
			true
		)
		References.player.target = References.player.path[0]


func _on_object_menu_toggle(toggleState, object_menu, _from_node): #Object node emit
#called when user clicks on an object
#shows or hides the menu
	if References.dialog.in_progress == false:
		if (playerInput == true):
			if(toggleState):
				object_menu.hide_menu() #replace with tween
			else:
				object_menu.show_menu() #replace with tween


func _on_examine(object_menu_btn): #References node emit from object menu click
	if (playerInput == true && worldInput == true):
		prints(object_menu_btn.buttonType, " | ", object_menu_btn.object_node.description)
		object_menu_btn.object_node.toggleState = !object_menu_btn.object_node.toggleState
		object_menu_btn.get_parent().hide_menu()
		#pass dialog text array to dialogbox and tell it to start
		References.dialog.start_dialog(object_menu_btn.object_node.description, 0)


func _on_forage(object_menu_btn, forage_key): #References node emit from object menu click
	if (playerInput == true && worldInput == true):
		prints(object_menu_btn.buttonType, " | ", object_menu_btn.object_node.description, forage_key)
		object_menu_btn.object_node.toggleState = !object_menu_btn.object_node.toggleState
		object_menu_btn.get_parent().hide_menu()
		References.forageOverlay.show_overlay(forage_key)
	


func _on_forage_overlay_close_btn():
	References.forageOverlay.hide_overlay()


func _on_clicked_plant(_from_node):
	References.forageOverlay.brushed_count += 1
	References.forageOverlay.handle_plant_state_update()
