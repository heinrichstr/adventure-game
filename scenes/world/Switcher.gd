extends Node2D
#functional component that handles transitioning scenes


@export var load_scene:PackedScene

var scene_ids = [
	{
		"id": "meadow-1",
		"scenepath": "res://scenes/world/meadow/SpaceMeadow1.tscn"
	},
	{
		"id": "home",
		"scenepath": "res://scenes/world/meadow/Home.tscn"
	}
]

# Called when the node enters the scene tree for the first time.
func _ready():
	References.spaceSwitcher_node = self
	replaceScene("home", "northwest")


func replaceScene(sceneId, spawn_loc):
	var scenepath
	for scene in scene_ids:
		if scene.id == sceneId:
			scenepath = scene.scenepath
	
	if scenepath:
		var sceneLoader = load(scenepath)
		
		#darken and set no interact
		Actions.toggle_player_input()
		var tween = get_tree().create_tween()
		tween.tween_property($CanvasLayer/ColorRect, "modulate", Color(0,0,0,1), .5).set_trans(Tween.TRANS_SINE)
		await tween.finished
		tween.kill()
		
		_handle_space_children(sceneLoader, spawn_loc)
		
		#lighten and set interact
		tween = get_tree().create_tween()
		tween.tween_property($CanvasLayer/ColorRect, "modulate", Color(0,0,0,0), .5).set_trans(Tween.TRANS_SINE)
		await tween.finished
		tween.kill()
		Actions.toggle_player_input()


func _handle_space_children(child_scene, spawn_loc):
	var children = $SpaceContainer.get_children()
	for child in children:
		child.queue_free()
	
	var new_child = child_scene.instantiate()
	new_child.spawn_loc = spawn_loc
	
	$SpaceContainer.call_deferred("add_child", new_child)
