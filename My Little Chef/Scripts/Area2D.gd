extends Area2D

signal change_player_sprite
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func get_input():
	# check if player is overlapping area
	var bodies = get_overlapping_bodies()
	# check if user is pressing e whle overlapping area if true emit signal to 
	# change the sprite appearance
	if Input.is_action_just_released("exit"):
		if _on_Wardrobe_body_entered(bodies):
			emit_signal("change_player_sprite")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_input()



func _on_Wardrobe_body_entered(body):
	return true
	#if Input.is_action_pressed("exit"):
	#emit_signal("change_player_sprite") # Replace with function body.
