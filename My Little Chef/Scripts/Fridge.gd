extends Area2D


#signal pick_up(item_id)
#signal put_down

var fridge_inventory = ItemAuto.Inventory.new(Global.new_inst)
var item_id
# Called when the node enters the scene tree for the first time.
func _ready():
	$Closed.show()
	$Opened.hide()
	fridge_inventory.add_item("raw_ingredients", 10)
	print("there are : ", fridge_inventory.get_item_count("raw_ingredients"), " raw_ingredients in the fridge's inventory")
	#item_id = fridge_inventory._item_data.new_inst._dict["raw_ingredients"].icon
	print(fridge_inventory)
	print(fridge_inventory._dict)
	print(fridge_inventory._dict["raw_ingredients"])
	print(fridge_inventory._item_data._dict["raw_ingredients"].id)


func get_input():
	var bodies = get_overlapping_bodies()
	var player_is_in = false
	# check if user is pressing e whle overlapping area if true emit signal to 
	# change the sprite appearance
	for bod in bodies:
		if bod.is_in_group("player"):
			player_is_in = true
			break
	
	if player_is_in and Input.is_action_just_pressed("exit"):
		item_id = "raw_ingredients"
		if !Player.hands_full :
			SignalManager.emit_signal("pick_up", item_id)
			fridge_inventory.remove_item("raw_ingredients", 1)
			print("SENDING SIGNAL pick_up")
			#mark players hands as full
		elif Player.hands_full and (Player.player_inventory._dict.has(item_id)):
			print("SENDING SIGNAL put_down")
			SignalManager.emit_signal("put_down")
			fridge_inventory.add_item("raw_ingredients", 1)


func _process(delta):
	get_input()
