extends Node

var world
var player
var space
var dialog
var forageOverlay

signal examine(_from_node)
signal forage(_from_node, forage_key, forage_target)

var actions = {
	"examine": {
		"signal_call": func(_from_node): emit_signal("examine", _from_node),
		"desc": "EXAMINE"
	}, 
	"forage": {
		"signal_call": func(_from_node, forage_key, forage_target): emit_signal("forage", _from_node,forage_key, forage_target),
		"desc": "FORAGE",
		"forage_key": "meadow-1",
		"target_herb": "rose"
	}
}


var forages = {
	"meadow-1": "res://scenes/forage/meadow-1.tscn"
}

var forage_targets = {
	"rose": "res://assets/sprites/forage/meadow/rose-herb.png"
}


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("examine", Actions._on_examine)
	connect("forage", Actions._on_forage)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
