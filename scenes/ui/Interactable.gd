extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$'./InteractBtn'.hide()
	close_interact("prompt")
	$Cloud/AnimationPlayer.play("closed")


func open_interact(state):
	$Cloud/AnimationPlayer.play("closed")
	show()
	$Cloud/AnimationPlayer.play("open")


func close_interact(state):
	$'./InteractBtn'.hide()
	$Cloud/AnimationPlayer.play("close")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "open":
		$Cloud/AnimationPlayer.play("idle")
		$'./InteractBtn'.show()
	elif anim_name == "close":
		$'./InteractBtn'.hide()
		hide()


func open_options():
	print('opening')
