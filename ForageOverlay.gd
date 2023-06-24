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
var leftActive = false

var inputCounter
var totalBarrierCount
var forageBarrier = preload("res://scenes/forage/forage_barrier.tscn")

func _ready():
	References.forageOverlay = self

func show_overlay(forage_key, forage_target):
	print("FORAGING", forage_key, forage_target)
	#prepare anim and data
	overlay_forage_key = forage_key
	overlay_forage_target = forage_target
	Actions.playerInput = false
	active = true
	$BackgroundColor.modulate = Color(0,0,0,1)
	$TargetPlant.reset()
	
	#reset state
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	totalBarrierCount = rng.randi_range(6, 10)
	inputCounter = 0
	
	#load target plant
	
	#load forage barriers
	var barrierCounter = 1
	for barrier in totalBarrierCount:
		var barrierInstance = forageBarrier.instantiate()
		
		if barrierCounter % 2 == 1:
			barrierInstance.left = true
		else:
			barrierInstance.left = false
		barrierCounter += 1
		
		barrierInstance.forage_loc = forage_key
		barrierInstance.order = barrierCounter
		
		$Forage.add_child(barrierInstance)
	
	#set forage barrier modulation
	var childCounter = 0
	var maxChildren = $Forage.get_child_count()
	for child in $Forage.get_children():
		#modulate all but the front two
		if childCounter - maxChildren >= -2:
			pass
		else:
			child.modulate = Color(.5, .5, .5, 1)
		
		childCounter += 1
	
	#pull up overlay screen
	var tw = create_tween().set_parallel().set_trans(1).set_ease(1)
	tw.tween_property(self, "position", Vector2(0,0), .5)
	tw.tween_property(self, "modulate", Color(1, 1, 1, 1), .5)
	await tw.finished
	Actions.playerInput = true
	Actions.worldInput = false


func hide_overlay():
	#hides and resets the overlay, including unloading the forage items
	
	Actions.playerInput = false
	var tw = create_tween().set_parallel().set_trans(1).set_ease(1)
	tw.tween_property(self, "position", Vector2(0,1100), .5)
	tw.tween_property(self, "modulate", Color(0, 0, 0, 1), .5)
	tw.tween_property($TextureButton, "modulate", Color(1, 1, 1, 0), .25)
	$ForageEndScreen.fade_out()
	
	await tw.finished
	
	Actions.playerInput = true
	Actions.worldInput = true
	for n in $Forage.get_children():
		$Forage.remove_child(n)
		n.queue_free()


func load_forage(forage_key:String): #OLD
	#loads in which forage overlay to use
	#TODO also load in the herb sprite and set the target plant to that herb
	
	var instancePath = References.forages[forage_key]
	var forageInstance = load(instancePath)
	var forage = forageInstance.instantiate()
	$Forage.add_child(forage)
	plant_count = $Forage.get_child(0).get_child_count()
	$TargetPlant.texture = load(References.forage_targets[overlay_forage_target])
	$ForageEndScreen/VBoxContainer/Sprite2D.texture = load(References.forage_targets[overlay_forage_target])
	#Called via signal by Actions
	#Slowly reveals the herb and background
	
	if brushed_count <= plant_count:
		var colorBalance = float(brushed_count)/float(plant_count)
		$BackgroundColor.modulate = Color(colorBalance,colorBalance,colorBalance,1)
		$TargetPlant.modulate = Color(colorBalance*.5,colorBalance*.5,colorBalance*.5,colorBalance)
	if brushed_count == plant_count:
		$TargetPlant.set_active()
		$TargetPlant.modulate = Color(1,1,1,1)


func _unhandled_input(event):
	if Actions.player_input(event) == "bumper_right":
		if leftActive == false:
			inputCounter += 1
			#check if over the total count
			#if not over, loop through the Forage nodes and grab the current active on that side
				#push over that Forage node
				#set leftActive to the opposite side to prepare for the next input
				#emit signal for buttons to reread state
	elif Actions.player_input(event) == "bumper_left":
		if leftActive == true:
			pass

func finish_game():
	print("game finish")
	$ForageEndScreen.fade_in()
	#Show herb picked UI
		#include shiny sprite
		#include btn to add to inventory
