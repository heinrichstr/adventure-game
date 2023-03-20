extends Node2D
#functional component that handles transitioning scenes


@export var load_scene:PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func replaceScene(scenePath):
	var sceneLoader = load(scenePath)
	load_scene = sceneLoader
	
	var children = get_children()
	for child in children:
		child.queue_free()
	
	var scene_to_add = load_scene.instantiate()
	add_child(scene_to_add)
