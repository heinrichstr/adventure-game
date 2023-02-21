extends CharacterBody2D

var speed = 400
var input_vector:Vector2 = Vector2.ZERO
var past_vector:Vector2
var overlapping:Array

func _ready():
	$AnimationTree.get("parameters/playback").travel("idle-loop")


func get_input():
	input_vector.x = Input.get_action_strength("player_right") - Input.get_action_strength("player_left")
	input_vector.y = Input.get_action_strength("player_down") - Input.get_action_strength("player_up")
	input_vector = input_vector.normalized()


func update_anim_params(move_vector:Vector2):
	$AnimationTree.set("parameters/Movement/blend_position", input_vector)


func animate_overlapping_grass():
	print("movement triggered overlap")
	overlapping = $Area2D.get_overlapping_areas()
	for area in overlapping:
		prints("overlap detected", area, area.is_in_group("grass_walkable"))
		if area.is_in_group("grass_walkable"):
			var sprite = area.get_parent()
			#TODO: Check global pos of player vs grass, push anim based on difference
			if sprite.get_node("AnimationPlayer").is_playing() == false:
				if sprite.get_global_position() > self.get_global_position():
					sprite.get_node("AnimationPlayer").play("push_right")
				else:
					sprite.get_node("AnimationPlayer").play("push_left")


func _physics_process(delta):
	$"AnimationTree".advance(delta)
	get_input()
	
	if input_vector == Vector2.ZERO:
		$AnimationTree.get("parameters/playback").travel("idle-loop")
	else:
		$AnimationTree.get("parameters/playback").travel("Movement")
		animate_overlapping_grass()
	
	update_anim_params(input_vector)
	velocity = input_vector * speed
	move_and_slide()
	
	if Input.is_action_pressed("player_left") || Input.is_action_pressed("player_right") || Input.is_action_pressed("player_up") || Input.is_action_pressed("player_down"):
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	
	
	past_vector = input_vector
