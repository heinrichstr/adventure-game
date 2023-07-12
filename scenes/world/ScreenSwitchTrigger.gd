extends Area2D

@export var to_scene:String
@export var spawn_loc:String

signal switch_space_to(space_string_id, spawn_loc)

func _ready():
	switch_space_to.connect(Callable(Actions._on_space_switcher))

func _on_area_entered(area):
	if area == References.player.find_child("PlayerArea2D"):
		switch_space_to.emit(to_scene, spawn_loc)
