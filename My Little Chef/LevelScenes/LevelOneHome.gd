extends Node2D

#preload player scene so it is ready to be added to the scene
onready var the_player = preload("res://Player/PlayerCharacter.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	
	#get the position of the instanced child scene "Bed"
	# must be done after ready b/c otherwise it does not yet exist in scene
	var bed_pos = $TileMap/TileMap/Bed.position
	
	#instance the player scene
	var player_ = the_player.instance()
	add_child(player_)
	
	#set the instanced player scene to tbe same position as the bed
	player_.position = Global.door_dictionary.inner_door_home_one["new_player_position"]
	
	### TESTING SIGNALS TESTING SIGNALS TESTING SIGNALS ###
	SignalManager.connect("test_signal_one", self, "_on_test_signal_one")


func _on_test_signal_one():
	print("TEST SIGNAL ONE RECEIVED")
