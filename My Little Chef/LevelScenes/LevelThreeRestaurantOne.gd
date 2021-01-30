extends Node2D


onready var the_player = preload("res://Player/PlayerCharacter.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	print("This is", self.name) # Replace with function body.
	#var door_one_pos = Vector2($TileMap/TileMap/restaurantdoorTwo.position)
	#var instance_pos = door_one_pos
	#instance_pos.x += 10
	#instance_pos.y -= 45
	#instance the player scene
	var player_ = the_player.instance()
	add_child(player_)
	
	#set the instanced player scene to tbe same position as the bed
	player_.position = Global.door_dictionary.inner_door_restaurant_one["new_player_position"]
