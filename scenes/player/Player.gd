extends CharacterBody2D

var speed = 400
var input_vector:Vector2 = Vector2.ZERO
var past_vector:Vector2
var overlapping:Array

func _ready():
	$AnimationTree.get("parameters/playback").travel("idle-loop")


func get_input(keyboardUsed):
	var input_vector_temp
	if keyboardUsed:
		input_vector_temp = Input.get_vector("player_left","player_right","player_up","player_down")
	else:
		input_vector_temp = Input.get_vector("gamepad_left","gamepad_right","gamepad_up","gamepad_down")
	
	input_vector_temp = input_vector_temp.normalized()
	print("vector; ", input_vector_temp)
	return input_vector_temp


func update_anim_params(move_vector:Vector2):
	$AnimationTree.set("parameters/Movement/blend_position", input_vector)


func animate_overlapping_grass():
	overlapping = $PlayerArea2D.get_overlapping_areas()
	for area in overlapping:
		if area.is_in_group("grass_walkable") && area.get_parent().walkable:
			var sprite = area.get_parent()
			#TODO: Check global pos of player vs grass, push anim based on difference
			if sprite.get_node("AnimationPlayer").is_playing() == false:
				if sprite.get_global_position() > self.get_global_position():
					sprite.get_node("AnimationPlayer").play("push_right")
				else:
					sprite.get_node("AnimationPlayer").play("push_left")


func _physics_process(delta):
	$"AnimationTree".advance(delta) #makes the animations play better? Currently an engine issue (4.0 rc2)
	
	if Actions.playerInput: #if actions are allowed
		if Input.is_action_pressed("gamepad_up") || Input.is_action_pressed("gamepad_down") || Input.is_action_pressed("gamepad_left") || Input.is_action_pressed("gamepad_right"):
			References.State.keyboard = false
		elif Input.is_action_pressed("player_up") || Input.is_action_pressed("player_down") || Input.is_action_pressed("player_left") || Input.is_action_pressed("player_right"):
			References.State.keyboard = true
		
		var input = get_input(References.State.keyboard) #Update movement vector
		
		#set anim state based on movement vector
		if input == Vector2.ZERO:
			$AnimationTree.get("parameters/playback").travel("idle-loop")
		else:
			$AnimationTree.get("parameters/playback").travel("Movement")
			#Check and see if player walks through grass and if so, animate it
			animate_overlapping_grass()
		
		#Move the player with animation
		update_anim_params(input)
		velocity = input * speed
		move_and_slide()
		
		#Hide cursor when moving (May remove in future)
		if References.State.keyboard == false:
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		elif References.State.keyboard == true:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
		past_vector = input
