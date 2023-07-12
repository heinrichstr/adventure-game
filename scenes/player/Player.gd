extends CharacterBody2D

var speed = 400
var input_vector:Vector2 = Vector2.ZERO
var past_vector:Vector2
var overlapping:Array
var joystickInput = false
var spawn_loc
@export var spawns:Array = [
	{
		"location": "default",
		"spawn_pos": Vector2(200, 200)
	},
	{
		"location": "northwest",
		"spawn_pos": Vector2(1020, 351)
	},
	{
		"location": "south",
		"spawn_pos": Vector2(1799, 1505)
	}
]

func _ready():
	$AnimationTree.get("parameters/playback").travel("idle-loop")
	References.player = self


func set_spawn_loc():
	prints("Setting player position: ", spawn_loc, get_parent().spawn_loc)
	
	self.position == spawns[0].spawn_pos #set default in case there are no matches
	
	for spawn in spawns: #see if there is a spawn that matches spawn_loc
		if spawn_loc == spawn.location:
			self.position = spawn.spawn_pos
			prints("spawn found: ", spawn.location, spawn.spawn_pos)
	
	prints("Result of spawn: ", self.position)


#button var that is set when a button is pressed, or set to joystick when a joystick is > 0.5 strength
#which vector to use is determined by button

func get_input_vector(eventType, event):
	#handles joystick input state, then gets movement Vector from input
	var input_vector_temp
	
	#handle joystick detection
	if eventType == "button":
		joystickInput = false
	elif eventType == "stick":
		var down = Input.get_action_strength("gamepad_down")
		var up = Input.get_action_strength("gamepad_up")
		var left = Input.get_action_strength("gamepad_left")
		var right = Input.get_action_strength("gamepad_right")
		
		if down > 0.5 or up > 0.5 or left > 0.5 or right > 0.5:
			joystickInput = true
	
	#handle setting movement vector based on above detection
	if joystickInput == false:
		input_vector_temp = Input.get_vector("player_left","player_right","player_up","player_down")
	elif joystickInput == true:
		input_vector_temp = Input.get_vector("gamepad_left","gamepad_right","gamepad_up","gamepad_down")
	
	input_vector_temp = input_vector_temp.normalized()
	input_vector = input_vector_temp


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


func _unhandled_input(event):
	#Detect input and organize by input type (either button press on keyboard/dpad or joystick motion)
	if Actions.playerInput == true:
		if event is InputEventJoypadMotion:
			get_input_vector("stick", event)
		elif event is InputEventKey or event is InputEventJoypadButton:
			get_input_vector("button", event)


func _physics_process(delta):
	$"AnimationTree".advance(delta) #makes the animations play better? Currently an engine issue (4.0 rc2)
	
	#set anim state based on movement vector
	if input_vector == Vector2.ZERO:
		$AnimationTree.get("parameters/playback").travel("idle-loop")
	else:
		$AnimationTree.get("parameters/playback").travel("Movement")
		#Check and see if player walks through grass and if so, animate it
		animate_overlapping_grass()
	
	#Move the player with animation based on input vector variable
	update_anim_params(input_vector)
	velocity = input_vector * speed
	
	move_and_slide()
	
	past_vector = input_vector
