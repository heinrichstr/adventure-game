extends Node2D

@onready var default_2d_map_rid : RID = get_world_2d().get_navigation_map()
var playerInput = true #can players provide inputs to the game?


func _ready():
	pass # Replace with function body.


func _process(_delta):
	pass


func _on_click_on_space(target, _from_node): #Space node emit
# called when user clicks on the screen to move the character
# creates an array of Vector2() paths navigating with the navmesh of the Space
# setting the target on the player causes the player to move
	if (playerInput == true):
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
	if (playerInput == true):
		if(toggleState):
			object_menu.hide_menu() #replace with tween
		else:
			object_menu.show_menu() #replace with tween
