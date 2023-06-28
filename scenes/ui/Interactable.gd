extends Node2D

var object
var openState = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$InteractionPrompt.interactableNode = self
	$'./ButtonHintSprite'.hide()
	$Cloud/AnimationPlayer.play("closed")


func open_interact(state):
	$Cloud/AnimationPlayer.play("closed")
	show()
	$Cloud/AnimationPlayer.play("open")


func close_interact(state):
	$'./ButtonHintSprite'.hide()
	$Cloud/AnimationPlayer.play("close")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "open":
		$Cloud/AnimationPlayer.play("idle")
		$'./ButtonHintSprite'.show()
	elif anim_name == "close":
		$'./ButtonHintSprite'.hide()
		hide()


func load_menu(actions):
	$InteractionPrompt.show_menu(actions)
	openState = true


func close_menu():
	$InteractionPrompt.close_menu()
	openState = false


func get_active_btn():
	return($InteractionPrompt.get_active_btn())
