extends Node2D

var spawn_loc

func _ready():
	References.space = self
	References.player = $Player
	$Player.spawn_loc = spawn_loc
	$Player.set_spawn_loc()
