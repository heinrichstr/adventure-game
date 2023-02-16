extends Node2D
#Container that loads in the forage game

var brushed_count = 0
var plant_count
var overlay_forage_key
var overlay_forage_target

func _ready():
	References.forageOverlay = self


func show_overlay(forage_key, forage_target): 
	#handles moving the forage screen in and setting up the screen
	
	#prints("received key", forage_key, "for target", forage_target)
	overlay_forage_key = forage_key
	overlay_forage_target = forage_target
	Actions.playerInput = false
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
		$TargetPlant.modulate = Color(1,1,1,colorBalance)
	if brushed_count == plant_count:
		$TargetPlant.set_active()


func finish_game():
	print("game finish")
	$ForageEndScreen.fade_in()
	#Show herb picked UI
		#include shiny sprite
		#include btn to add to inventory
