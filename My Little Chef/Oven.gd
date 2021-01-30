extends Area2D


onready var oven_rack = "empty"
var item_id = "basic_bread"

# Called when the node enters the scene tree for the first time.
func _ready():
	$FilledOven.hide()
	$FinishedOven.hide()


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
		if oven_rack == "empty" and (Player.player_inventory._dict.has("basic_dough")):
			SignalManager.emit_signal("put_down")
			print("OVEN EMITTING SIGNAL PUT DOWN")
			_fill_oven()
		elif oven_rack == "full" and Player.hands_full == false:
			SignalManager.emit_signal("pick_up", item_id)
			_empty_oven()
		else:
			print("you can't put anything else in the oven right now")
	
	if oven_rack == "empty":
		$FinishedOven.hide()


func _process(delta):
	get_input()


func _fill_oven():
	$FilledOven.show()
	$OvenTimer.start()
	oven_rack = "full"


func _empty_oven():
	$FinishedOven.hide()
	oven_rack = "empty"


func _on_OvenTimer_timeout():
	$FinishedOven.show()
	$FilledOven.hide() # Replace with function body.
