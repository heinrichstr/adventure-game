extends Node2D
#Container that loads in the forage game

var brushed_count = 0
var plant_count

func _ready():
	References.forageOverlay = self


func show_overlay(forage_key):
	prints("received key", forage_key)
	Actions.playerInput = false
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
	Actions.playerInput = false
	var tw = create_tween().set_parallel().set_trans(1).set_ease(1)
	tw.tween_property(self, "position", Vector2(0,1100), .5)
	tw.tween_property(self, "modulate", Color(0, 0, 0, 1), .5)
	tw.tween_property($TextureButton, "modulate", Color(1, 1, 1, 0), .25)
	brushed_count = 0
	plant_count = 0
	$BackgroundColor.modulate = Color(0,0,0,1)
	await tw.finished
	Actions.playerInput = true
	Actions.worldInput = true
	for n in $Forage.get_children():
		$Forage.remove_child(n)
		n.queue_free()


func load_forage(forage_key:String):
	var instancePath = References.forages[forage_key]
	var forageInstance = load(instancePath)
	var forage = forageInstance.instantiate()
	$Forage.add_child(forage)
	plant_count = $Forage.get_child(0).get_child_count()


func handle_plant_state_update():
	if brushed_count < plant_count:
		var colorBalance = float(brushed_count)/float(plant_count + 1)
		$BackgroundColor.modulate = Color(colorBalance,colorBalance,colorBalance,1)
