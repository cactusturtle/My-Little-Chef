extends Node

# from multiple sources to player variable and parent dictionary
signal pick_up(location)
signal put_down

# from Door.gd to Global.gd
signal player_leaving(string)

# from global to palyer variables
signal scene_changed

# from chair objects to player variables
signal player_sitting(chair)
signal player_not_sitting(chair)

# from wardrobe objects to player variables
signal change_player_sprite

# test signals
signal test_signal_one
signal test_signal_two(value)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
