extends Node2D
#Container that loads in the forage game

var plant_count
var overlay_forage_key
var overlay_forage_target
var velocity = Vector2(0,0)
var active = false
var targetActive = false
var joystickInput = false
var input_vector_temp
var leftActive = false

var inputCounter
var totalBarrierCount
var targetPlantInputCounter
var forageBarrier = preload("res://scenes/forage/forage_barrier.tscn")

func _ready():
	References.forageOverlay = self

func show_overlay(forage_key, forage_target):
	#Debug print("FORAGING", forage_key, forage_target)
	#prepare anim and data
	overlay_forage_key = forage_key
	overlay_forage_target = forage_target
	Actions.playerInput = false
	active = true
	targetActive = false
	$BackgroundColor.modulate = Color(0,0,0,1)
	$TargetPlant.reset()
	
	#reset state
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	totalBarrierCount = rng.randi_range(6, 10)
	inputCounter = 0
	
	#Handle the first input button
	if totalBarrierCount % 2 == 0:
		leftActive = true
	else: 
		leftActive = false
		
	update_icons()
	
	#load target plant
	load_forage(forage_key)
	
	#load forage barriers
	var barrierCounter = 1
	for barrier in totalBarrierCount:
		var barrierInstance = forageBarrier.instantiate()
		
		if barrierCounter % 2 == 1:
			barrierInstance.left = false
		else:
			barrierInstance.left = true
		
		barrierInstance.forage_loc = forage_key
		barrierInstance.forageOrder = barrierCounter
		
		barrierCounter += 1
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
	active = false
	targetActive = false
	
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


func load_forage(forage_key:String):
	#loads forage target
	
	$TargetPlant.texture = load(References.forage_targets[overlay_forage_target])
	$ForageEndScreen/VBoxContainer/Sprite2D.texture = load(References.forage_targets[overlay_forage_target])


func calculate_forage_state():
	var colorBalance = float(inputCounter -1)/float(totalBarrierCount)
	$BackgroundColor.modulate = Color(colorBalance,colorBalance,colorBalance,1)
	$TargetPlant.modulate = Color(colorBalance*.5,colorBalance*.5,colorBalance*.5,colorBalance)


func _unhandled_input(event):
	if active:
		if Actions.player_input(event) == "bumper_right":
			if leftActive == false:
				inputCounter += 1
				if inputCounter < totalBarrierCount:
					push_over_forage()
					leftActive = true
					update_icons()
					calculate_forage_state()
				else:
					push_over_forage()
					calculate_forage_state()
					start_target_plant_game()
		elif Actions.player_input(event) == "bumper_left":
			if leftActive == true:
				inputCounter += 1
				if inputCounter < totalBarrierCount:
					push_over_forage()
					leftActive = false
					update_icons()
					calculate_forage_state()
				else:
					push_over_forage()
					calculate_forage_state()
					start_target_plant_game()
	elif targetActive:
		if Actions.player_input(event) == "input":
			print("pull")
			targetPlantInputCounter += 1
			
			if targetPlantInputCounter > 5:
				finish_game()
			else:
				$TargetPlant.play_click_anim()


func push_over_forage():
	for forage in $Forage.get_children():
		if forage.forageOrder == totalBarrierCount - (inputCounter - 1):
			forage.push_barrier()


func start_target_plant_game():
	$BackgroundColor.modulate = Color(1,1,1,1)
	$TargetPlant.modulate = Color(1,1,1,1)
	$ButtonHintSpriteLeft.hide()
	$ButtonHintSpriteRight.hide()
	$TargetPlant.set_active()
	#show new input button
	
	active = false
	targetActive = true
	targetPlantInputCounter = 0
	print('game on bitches')


func update_icons():
	if leftActive:
		$ButtonHintSpriteLeft.show()
		$ButtonHintSpriteRight.hide()
	elif leftActive == false:
		$ButtonHintSpriteLeft.hide()
		$ButtonHintSpriteRight.show()


func finish_game():
	print("game finish")
	$ForageEndScreen.fade_in()
	#Show herb picked UI
		#include shiny sprite
		#include btn to add to inventory
