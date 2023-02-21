extends CharacterBody2D

var speed = 400
var input_vector:Vector2 = Vector2.ZERO
var past_vector:Vector2


func _ready():
	$AnimationTree.get("parameters/playback").travel("idle-loop")


func get_input():
	input_vector.x = Input.get_action_strength("player_right") - Input.get_action_strength("player_left")
	input_vector.y = Input.get_action_strength("player_down") - Input.get_action_strength("player_up")
	input_vector = input_vector.normalized()


func update_anim_params(move_vector:Vector2):
	$AnimationTree.set("parameters/Movement/blend_position", input_vector)


func _physics_process(delta):
	$"AnimationTree".advance(delta)
	get_input()
	
	if input_vector == Vector2.ZERO:
		$AnimationTree.get("parameters/playback").travel("idle-loop")
	else:
		$AnimationTree.get("parameters/playback").travel("Movement")
	
	update_anim_params(input_vector)
	velocity = input_vector * speed
	move_and_slide()
	
	if Input.is_action_pressed("player_left") || Input.is_action_pressed("player_right") || Input.is_action_pressed("player_up") || Input.is_action_pressed("player_down"):
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	past_vector = input_vector
