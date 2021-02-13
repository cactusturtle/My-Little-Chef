extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func get_input():
	var bodies = get_overlapping_bodies()
	var player_is_in_km = false
	
	for bod in bodies:
		if bod.is_in_group("player"):
			player_is_in_km = true
			break

	
	if player_is_in_km and Input.is_action_just_pressed("exit"):
		if Player.hands_full == true:
			SignalManager.emit_signal("put_down")
			SignalManager.emit_signal("serve_customer")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_input()
