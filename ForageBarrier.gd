extends Node2D

var left = true
var spriteIndex = 0
var forage_loc
var order = 0

func _ready():
	load_sprite_by_loc(forage_loc)
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	spriteIndex = rng.randi_range(0, 5)
	$AnimatedSprite2D.frame = spriteIndex
	position.y = order * -10
	
	if left:
		$AnimatedSprite2D.position.x = -250 + (10 * spriteIndex)
	else:
		$AnimatedSprite2D.position.x = 500 + (10 * spriteIndex)
		$AnimatedSprite2D.flip_h = true
	
	$AnimatedSprite2D.material.set_shader_parameter("offset", $AnimatedSprite2D.position.x/200)
	$AnimatedSprite2D.material.set_shader_parameter("maxStrength", .05)
	prints("barrier set at pos ", $AnimatedSprite2D.position.x, " with index of ", spriteIndex, " and left equals ", left)


func push_barrier():
	if left:
		$AnimatedSprite2D.offset = Vector2(-200, 50)
	else:
		$AnimatedSprite2D.offset = Vector2(200, 50)
	
	$AnimatedSprite2D.rotation = 90
	$AnimatedSprite2D.material.set_shader_parameter("maxStrength", .005)


func load_sprite_by_loc(forage_loc):
	prints("loading spite by loc", forage_loc)
	#TODO: Load forage sprite by location
