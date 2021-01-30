extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func get_input():
	# check if player is overlapping area
	var bodies = get_overlapping_bodies()
	var player_is_in = false
	# check if user is pressing e whle overlapping area if true emit signal to 
	# change the sprite appearance
	for bod in bodies:
		if bod.is_in_group("player"):
			player_is_in = true
			break
	
	if player_is_in and Input.is_action_just_released("exit"):
		print("trying to emit signal")
		SignalManager.emit_signal("change_player_sprite")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_input()



func _on_Wardrobe_body_entered(body):
	if body.is_in_group("player"):
		return true
	#if Input.is_action_pressed("exit"):
	#emit_signal("change_player_sprite") # Replace with function body.

