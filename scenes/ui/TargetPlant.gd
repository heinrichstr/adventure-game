extends Sprite2D

var clickable = false
var clickBuffer = false
var clickerCount = 6
signal picked_herb(_from_node)
var particlesInstance = load("res://scenes/forage/Forage_particles_meadow.tscn")



func _ready():
	connect("picked_herb", Actions._on_picked_herb)
	


func _unhandled_input(event):
	#handles animation and logic when clicked and allowed to be clicked
	if event.is_action_pressed('click') && clickable:
		if clickBuffer: #prevents firing a click too soon on forage screen
			if clickerCount == 0:
				#launch picked modal
				print("PICKED")
				clickable = false
				emit_signal("picked_herb", self)
				
				#tween the remote transform to make the sprite follow the path
				var tw = create_tween().set_parallel().set_trans(0).set_ease(0)
				tw.tween_property($"../Path2D/PathFollow2D/RemoteTransform2D", "scale", Vector2(0, 0), 2)
				tw.tween_property($"../Path2D/PathFollow2D", 'progress_ratio', 1, 2)
				tw.tween_property(self, 'z_index', 100, 1).set_delay(0.8)
			
			play_click_anim()
			clickerCount -= 1
		else:
			clickBuffer = true


func play_click_anim(): #handles animating the sprite pos when clicked and particles
	var particles = particlesInstance.instantiate()
	particles.position = Vector2(960, 1080)
	$"..".add_child(particles)
	particles.emitting = true
	
	var tw = create_tween().set_trans(1).set_ease(1)
	tw.tween_property(self, "position", Vector2(position.x, position.y + 10), .05)
	tw.tween_property(self, "position", Vector2(position.x, position.y-5), .1)
	tw.tween_property(particles, "modulate", Color(1,1,1,0), 5).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUINT)
	
	await get_tree().create_timer(5.0).timeout
	particles.queue_free()


func set_active():
	clickable = true


func reset(): #called to set back to base
	modulate = Color(1,1,1,0)
	clickable = false
	clickBuffer = false
	position.y = 590
	clickerCount = 6
	scale = Vector2(6,6)
	position = Vector2(960, 590)
	$"../Path2D/PathFollow2D/RemoteTransform2D".scale = Vector2(6,6)
	$"../Path2D/PathFollow2D".progress_ratio = 0
	z_index = 0
