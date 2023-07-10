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
	replaceScene("home")


func replaceScene(sceneId):
	#search for id, get scene path for that id
	var scenepath
	for scene in scene_ids:
		if scene.id == sceneId:
			scenepath = scene.scenepath
	
	var sceneLoader = load(scenepath)
	load_scene = sceneLoader
	
	var children = get_children()
	for child in children:
		child.queue_free()
	
	var scene_to_add = load_scene.instantiate()
	add_child(scene_to_add)
