extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func open_interact():
	$Cloud/AnimationPlayer.play("open")


func oclose_interact():
	$Cloud/AnimationPlayer.play("close")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "open":
		$Cloud/AnimationPlayer.play("idle")
