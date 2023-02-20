extends CharacterBody2D

var speed = 400
var animation_dir
var target
var path
var input_vector = Vector2.ZERO

func _ready():
	$AnimationPlayer.play("idle")


func get_input():
	input_vector.x = Input.get_action_strength("player_right") - Input.get_action_strength("player_left")
	input_vector.y = Input.get_action_strength("player_down") - Input.get_action_strength("player_up")
	input_vector = input_vector.normalized()

func _physics_process(_delta):
	get_input()
	
	prints("anim_dir", input_vector)
	if input_vector == Vector2.ZERO:
		print("IDLE")
		$AnimationTree.get("parameters/playback").travel("Idle")
	else:
		print("MOVE")
		$AnimationTree.get("parameters/playback").travel("Movement")
		velocity = input_vector * speed
		move_and_slide()
		$AnimationTree.set("parameters/Idle/blend_position", input_vector)
		$AnimationTree.set("parameters/Walk/blend_position", input_vector)
	
	if Input.is_action_pressed("player_left") || Input.is_action_pressed("player_right") || Input.is_action_pressed("player_up") || Input.is_action_pressed("player_down"):
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	
