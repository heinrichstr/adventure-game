extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	for n in get_children():
		n.set_frame_and_progress(randf_range(0, 2), 0)
		n.play('default')
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
