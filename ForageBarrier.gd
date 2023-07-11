extends Node2D

var left = true
var spriteIndex = 0
var forage_loc
var forageOrder = 0

func _ready():
	load_sprite_by_loc(forage_loc)
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	spriteIndex = rng.randi_range(0, 5)
	$AnimatedSprite2D.frame = spriteIndex
	position.y = forageOrder * -10
	
	if left:
		$AnimatedSprite2D.position.x = -250 + (10 * spriteIndex)
	else:
		$AnimatedSprite2D.position.x = 500 + (10 * spriteIndex)
		$AnimatedSprite2D.flip_h = true
	
	$AnimatedSprite2D.material.set_shader_parameter("offset", $AnimatedSprite2D.position.x/200)
	$AnimatedSprite2D.material.set_shader_parameter("maxStrength", .05)


func push_barrier():
	if left:
		$AnimatedSprite2D.position = Vector2($AnimatedSprite2D.position.x - 200,$AnimatedSprite2D.position.y + 400)
		$AnimatedSprite2D.rotation = -PI/12
	else:
		$AnimatedSprite2D.position = Vector2($AnimatedSprite2D.position.x + 200,$AnimatedSprite2D.position.y + 400)
		$AnimatedSprite2D.rotation = PI/12
	
	
	$AnimatedSprite2D.material.set_shader_parameter("maxStrength", .005)


func load_sprite_by_loc(forage_location):
	prints("loading spite by loc", forage_location)
	#TODO: Load forage sprite by location
