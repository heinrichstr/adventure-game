extends CharacterBody2D

var speed = 100
var target
var path

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	if (target):
		velocity = (target - position).normalized() * speed
		rotation = velocity.angle()
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
			rotation = 0
