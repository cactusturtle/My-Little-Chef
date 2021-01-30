extends Node
# VARIABLES
var current_scene = null
onready var new_inst = ItemAuto.ItemData.new()
# SIGNALS
signal scene_changed

# DICTIONARY FOR DOORS THROUGHOUT GAME
var door_dictionary = {
	inner_door_home_one = {
		"id" : 100,
		"name" : "inner_door_home_one",
		"in_scene" : "LevelOneHome",
		"going_to" : "res://LevelScenes/LevelTwoOutsideOne.tscn",
		"new_player_position" : Vector2(640, 320)
	},
	outer_door_home = {
		"name" : "outer_door_home",
		"in_scene" : "LevelTwoOutsideOne",
		"going_to" : "res://LevelScenes/LevelOneHome.tscn",
		"new_player_position" : Vector2(320, 140)
	},
	outer_door_restaurant = {
		"going_to": "res://LevelScenes/WholeRestaurantLevel.tscn",
		"new_player_position" : Vector2(320, 140)
	},
	inner_door_restaurant_one = {
		"going_to": "res://LevelScenes/LevelFourRestaurantTwo.tscn",
		"new_player_position" : Vector2(320, 250)
	},
	inner_door_restaurant_two = {
		"going_to": "res://LevelScenes/LevelTwoOutsideOne.tscn",
		"new_player_position" : Vector2(320, 250)
	},
	inner_door_kitchen = {
		"going_to": "res://LevelScenes/LevelThreeRestaurantOne.tscn",
		"new_player_position" : Vector2(320, 250)
	},
	restaurant_backdoor = {
		"going_to" : "res://LevelScenes/LevelTwoOutsideOne.tscn",
		"new_player_position" : Vector2(320, 250)
	}
}


# DISPLAY CAS DICTIONARY
var display_dict = {
	Display_001 = {
		space_1 = {
			"filled" : "empty",
			"icon" : ""
		},
		space_2 = {
			"filled" : "empty",
			"icon" : ""
		}
	},
	Display_002 = {
		space_1 = {
			"filled" : "empty",
			"icon" : ""
		},
		space_2 = {
			"filled" : "empty",
			"icon" : ""
		}
	},
	Display_003 = {
		space_1 = {
			"filled" : "empty",
			"icon" : ""
		},
		space_2 = {
			"filled" : "empty",
			"icon" : ""
		}
	}
}


func _on_Display_fill_display(display_fill):
	display_dict[display_fill[0]][display_fill[1]]["icon"] = Player.in_hands[0]
	display_dict[display_fill[0]][display_fill[1]]["filled"] = "full"


func _on_Display_empty_display(display_empty):
	display_dict[display_empty[0]][display_empty[1]]["icon"] = ""
	display_dict[display_empty[0]][display_empty[1]]["filled"] = "empty"



func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	
	for door in get_tree().get_nodes_in_group("doors"):
		var door_name = door.connect("player_leaving", self, "_on_Door_player_leaving", [name])
		print(door_name)
	
	self.connect("scene_changed", self, "_on_scene_change")
	
	## Initialize item database on game start
		# Instance new ItemData class object to hold the contents of all items in game
	# Load JSON file to pull item information from
	var temp_items = Global.load_json_file("res://LastItemList.json")
	print("CONTENTS OF :  ", temp_items)
	# If not an array then there was an error, wrong file mayeb loaded?
	if typeof(temp_items["items"]) == TYPE_ARRAY:
		print("temp_items is an ARRAY")
		var i = 0 
	# Loop through JSON file and create new items and append those items into dict
	# for later reference.
		while i < temp_items["items"].size():
			new_inst.create_item(temp_items["items"][i])
			i+=1
	elif typeof(temp_items) != TYPE_ARRAY:
			print("TYPE OF  :   ", typeof(temp_items))
	#print("new_isnt  :  ", new_inst)
	#print("new_inst._dict  :  ", new_inst._dict)
	print("new_inst._dict[raw_ingredients]  :  ", new_inst._dict["raw_ingredients"])
	print("new_inst._dict[raw_ingredients].id  :  ", new_inst._dict["raw_ingredients"].id)
	print(typeof(new_inst._dict["raw_ingredients"]))
	if typeof(new_inst._dict["raw_ingredients"]) == ERR_FILE_MISSING_DEPENDENCIES:
		print("ERROR FILE MISSING DEPENDINCIES")
	
	

func _on_Door_player_leaving(name, dictionary):
	print("_on_Door_player_leaving : ", name)
	print(name[0])
	if door_dictionary.has(name[0]):
		var find_me = name[0]
		name = null
		print(name)
		var new_path = Global.door_dictionary[find_me]["going_to"]
		goto_scene(new_path)
	#for door in get_tree().get_nodes_in_group("doors"):
		#var door_name = door.connect("player_leaving", self, "_on_player_leaving")


func goto_scene(path):
	call_deferred("_deferred_goto_scene", path)

func _deferred_goto_scene(path):
	current_scene.free()
	#current_scene.queue_free() # testing code
	var s = ResourceLoader.load(path)
	current_scene = s.instance()
	get_tree().get_root().add_child(current_scene)
	
	### TESTING CODE TO UPDATE IN PLAYERVARIABLES
	emit_signal("scene_changed")
	
	#testing out if we move receiver down here if itll work a second time
	# TEST SUCCESSFUL
	# Later use this one only when loading up from start scene!!
	for door in get_tree().get_nodes_in_group("doors"):
		var door_name = door.connect("player_leaving", self, "_on_Door_player_leaving", [name])
		print(door_name)

# IMPORTANT IMPORTANT IMPORTANT
# YOU MUST CONNECT SIGNALS IN THIS FUNCTION AS WELL
func _on_scene_change():
	pass
	# Connect Wardrobes after the scene changes
	#for display in get_tree().get_nodes_in_group("displays"):
		#display.connect("empty_display", self, "_on_Display_empty_display")
		#display.connect("fill_display", self, "_on_Display_fill_display")



### LOAD AND PARSE JSON FILE ###
"""Loads a JSON file from the given res path and return the loaded JSON object."""
### Calling the following function from a scene script:
### var loaded_object = load_json_file("res://game/json/abilities.json")
func load_json_file(path):
	var file = File.new()
	file.open(path, file.READ)
	var text = file.get_as_text()
	var result_json = JSON.parse(text)
	if result_json.error != OK:
		print("[load_json_file] Error loading JSON file '" + str(path) + "'.")
		print("\tError: ", result_json.error)
		print("\tError Line: ", result_json.error_line)
		print("\tError String: ", result_json.error_string)
		return null
	var obj = result_json.result
	print(typeof(obj))
	return obj
