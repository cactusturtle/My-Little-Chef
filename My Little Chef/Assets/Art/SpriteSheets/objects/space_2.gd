extends Area2D


var item_id


# Called when the node enters the scene tree for the first time.
func _ready():
	$FilledDisplayRight.hide()

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
		if Player.hands_full == false:
			if item_id != null:
				SignalManager.emit_signal("pick_up", item_id)
				empty_space()
			else:
				pass
		elif Player.hands_full == true:
			if item_id == null:
				item_id = Player.take_out
				SignalManager.emit_signal("put_down")
				fill_space()
			else:
				print("this space is full, you cannot put anything else down here")
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_input()


func fill_space():
	#$FilledDisplayRight.load(Global.new_inst._dict[item_id].icon)
	$FilledDisplayRight.show()
	$Label.text = "$" + str(Player.in_hands.sale_price)

func empty_space():
	$FilledDisplayRight.hide()
	item_id = null
	$Label.text = ""
