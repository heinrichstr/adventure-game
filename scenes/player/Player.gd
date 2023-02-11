extends CharacterBody2D

var speed = 200
var target
var path


func _ready():
	$AnimationPlayer.play("idle")


func _physics_process(_delta):
	#below determines direction angle, plays the anim accordingly, and then moves the player along the path if it has a target
	if (target):
		velocity = (target - position).normalized() * speed
		var velocity_angle = velocity.angle()/PI
		
		#Buckle up for radian math x.x
		#-.5 to .5 = right
		#-1 to -.5 or 1 to .5 = left
		#-.5 = up
		#.5 = down
		if velocity_angle > -.125 && velocity_angle < .125:
			#RIGHT
			$AnimationPlayer.play("right")
		elif velocity_angle < -.125 && velocity_angle > -.375:
			#UP_RIGHT
			$AnimationPlayer.play("up_right")
		elif velocity_angle < -.375 && velocity_angle > -.625:
			#UP
			$AnimationPlayer.play("up")
		elif velocity_angle < -.625 && velocity_angle > -.875:
			#UP_LEFT
			$AnimationPlayer.play("up_left")
		elif velocity_angle <= -.875 || velocity_angle >= .875:
			#LEFT
			$AnimationPlayer.play("left")
		elif velocity_angle > .125 && velocity_angle < .375:
			#DOWN_RIGHT
			$AnimationPlayer.play("down_right")
		elif velocity_angle > .375 && velocity_angle < .625:
			#DOWN
			$AnimationPlayer.play("down")
		elif velocity_angle > .625 && velocity_angle < .875:
			#DOWN_LEFT
			$AnimationPlayer.play("down_left")
		else:
			#IDLE
			$AnimationPlayer.play("idle")
		
		#Move the player along the nav path array (gifted to us by our lord and savior Singleton Actions)
		if (target - position).length() > 5 and path.size() > 0:
			# Player isn't at next path yet
			target = path[0]
			move_and_slide()
		elif (target - position).length() <= 5 and path.size() > 1:
			# The player gets to the next point
			path.remove_at(0)
			target = path[0]
			move_and_slide()
		else:
			# player gets to end of path
			$AnimationPlayer.play("idle")
