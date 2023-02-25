extends Node

var world
var player
var space
var dialog
var forageOverlay

var hand_cursor = preload("res://assets/sprites/ui/glove-cursor.png")
var default_cursor = preload("res://assets/sprites/ui/pointer-cursor.png")

signal examine(_from_node)
signal forage(_from_node, forage_key, forage_target)
signal talk(_from_node)
signal interact(_from_node)

var activeObject #objects update this when they are interactable

var objectActions = {
	"examine": {
		"signal_call": func(_from_node): emit_signal("examine", _from_node),
		"desc": "EXAMINE"
	}, 
	"forage": {
		"signal_call": func(_from_node, forage_key, forage_target): emit_signal("forage", _from_node,forage_key, forage_target),
		"desc": "FORAGE",
		"forage_key": "meadow-1",
		"target_herb": "rose"
	},
	"talk": {
		"signal_call": func(_from_node): emit_signal("talk", _from_node),
		"desc": "TALK"
	}, 
	"interact": {
		"signal_call": func(_from_node): emit_signal("interact", _from_node),
		"desc": "INTERACT"
	}, 
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
