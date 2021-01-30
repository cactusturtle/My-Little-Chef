extends Node


var player_position = Vector2(10, 10)
var item
# when flase use plainsprite, when true use chefsprite
onready var is_chef = false
onready var hands_full = false
onready var player_inventory = ItemAuto.Inventory.new(Global.new_inst)
onready var in_hands
### TESTING
#onready var the_player = preload("res://Player/PlayerCharacter.tscn")
### END TESTING

#onready var in_hands = player_inventory._item_data._dict[""].icon
var holding
var take_out
# Called when the node enters the scene tree for the first time.
func _ready():
	for drobes in get_tree().get_nodes_in_group("wardrobe"):
		SignalManager.connect("change_player_sprite", self, "_on_Wardrobe_change_player_sprite")
	
	Global.connect("scene_changed", self, "_on_scene_change")
	
	for fridges in get_tree().get_nodes_in_group("fridge"):
		fridges.connect("pick_up", self, "_on_pick_up")
	
	for fridges in get_tree().get_nodes_in_group("fridge"):
		fridges.connect("put_down", self, "_on_put_down")
	
	#for display in get_tree().get_nodes_in_group("displays"):
		#display.connect("display_put_down", self, "on_Display_display_pick_up")


func _on_Wardrobe_change_player_sprite():
	print("receiving wardrobe signal")
	if is_chef == false:
		is_chef = true
	elif is_chef == true:
		is_chef = false


func _on_pick_up(item):
	print("RECEIVING SIGNAL pick_up from fridge")
	#if player_inventory._dict.empty():
	if hands_full == false:
		player_inventory.add_item(item, 1)
		holding = player_inventory._item_data._dict[item].icon
		in_hands = player_inventory._item_data._dict[item]
		#store string_item_name of item just placed into inventory so it can be
		#removed later by the player and stored in the display memory
		take_out = player_inventory._item_data._dict[item].string_item_name
		print(player_inventory)
		print(player_inventory._dict)
	#in_hands.add_item(item, 1)
	#print("PLAYER IS HOLDING  :  ", in_hands)
	hands_full = true
	#the_player.Holding = load(in_hands[0])
	#player_holding = load(in_hands[0])


func _on_put_down():
	#var take_out = player_inventory._item_data._dict[item].string_item_name
	print("RECEIVING SIGNAL put_down")
	print(player_inventory)
	player_inventory.remove_item(take_out, 1)
	print(player_inventory)
	hands_full = false


func on_Display_display_pick_up(item):
	print("RECEIVING SIGNAL PICK UP FROM DISPLAY")
	hands_full = true


# IMPORTANT IMPORTANT IMPORTANT
# YOU MUST CONNECT SIGNALS IN THIS FUNCTION AS WELL

func _on_scene_change():
	#connect fridges after the scene changes
	for fridges in get_tree().get_nodes_in_group("fridge"):
		SignalManager.connect("pick_up", self, "_on_pick_up")
		SignalManager.connect("put_down", self, "_on_put_down")
	
	#for display in get_tree().get_nodes_in_group("displays"):
		#display.connect("display_put_down", self, "on_Display_display_pick_up")
"""
	# Connect Wardrobes after the scene changes
	for drobes in get_tree().get_nodes_in_group("wardrobe"):
		drobes.connect("change_player_sprite", self, "_on_Wardrobe_change_player_sprite")
"""
